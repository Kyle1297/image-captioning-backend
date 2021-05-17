import uuid, boto3, textwrap
from django.conf import settings
from django.db import models
from django.contrib.auth.models import User
from django.db import models
from .utils import upper_text
from django.utils import timezone

class Collection(models.Model):
    category = models.CharField("Category", unique=True, max_length=100, db_index=True)
    is_main = models.BooleanField("Main category", default=False)
    creator = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name="creators")
    
    class Meta:
        ordering = ['category']

    def __str__(self) -> str:
        return self.category

    def save(self, *args, **kwargs):
        """
        Ensure the 'category' field is always capitalized.
        """
        self.category = upper_text(self.category)
        super().save(*args, **kwargs)


class Image(models.Model):
    uuid = models.UUIDField("UUID", primary_key=True, unique=True, editable=False, default=uuid.uuid4)
    s3_key = models.CharField("Key", max_length=240)
    type = models.CharField("Type", max_length=100)
    width = models.PositiveIntegerField("Width", default=0)
    height = models.PositiveIntegerField("Height", default=0)
    title = models.CharField("Title", db_index=True, max_length=240)
    uploaded_at = models.DateTimeField(auto_now_add=True, editable=False) 
    is_profile_image = models.BooleanField("Profile image", default=False)
    is_private = models.BooleanField("Private image", default=False)
    collections = models.ManyToManyField(Collection, related_name="images", blank=True)
    uploader = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True, related_name="uploaders")
    likes = models.ManyToManyField(User, related_name="image_likes", blank=True)
    dislikes = models.ManyToManyField(User, related_name="image_dislikes", blank=True)
    views = models.PositiveIntegerField("Views", default=0)
    downloads = models.PositiveIntegerField("Downloads", default=0)

    class Meta:
        ordering = ['-uploaded_at']

    def __str__(self) -> str:
        return f"{textwrap.shorten(self.title, width=50, placeholder='...')}"

    def widthx():
        images = Image.objects.filter(width=None)
        for x in images:
            x.width = 0
            x.save()

    def heightx():
        images = Image.objects.filter(height=None)
        for x in images:
            x.height = 0
            x.save()

    def save(self, *args, **kwargs):
        """
        Ensure the 'title' field is always capitalized, and the 'type' field is upped on save.
        """
        self.title = upper_text(self.title)
        self.type = self.type.upper()
        super(Image, self).save(*args, **kwargs)

    def delete(self):
        """ 
        Remove image from s3 upon deletion.
        """
        s3 = boto3.resource("s3")
        s3.Object(settings.AWS_MEDIA_BUCKET_NAME, self.s3_key).delete()
        super(Image, self).delete()

    def total_likes(self) -> int:
        return self.likes.count()

    def total_dislikes(self) -> int:
        return self.dislikes.count()

    def total_reports(self) -> int:
        return self.reports.count()


class Caption(models.Model):
    text = models.CharField("Caption", max_length=500, db_index=True)
    satisfactory = models.BooleanField("Satisfactory", null=True)
    corrected_text = models.CharField("Corrected Caption", blank=True, max_length=240, db_index=True)
    image = models.OneToOneField(Image, on_delete=models.CASCADE, related_name="caption")
    last_updated = models.DateTimeField(auto_now=False, null=True)

    def __str__(self) -> str:
        if self.corrected_text:
            return self.corrected_text.capitalize()
        return self.text.capitalize()

    @classmethod
    def from_db(cls, db, field_names, values):
        """
        Save original values when model is loaded from database in a separate 
        attribute on the model.
        """
        instance = super().from_db(db, field_names, values)
        instance._loaded_values = dict(zip(field_names, values))
        
        return instance

    def save(self, *args, **kwargs):
        """
        Ensure the 'text' and 'corrected_text' fields are always 
        capitalized and last_updated field only updates when 
        corrected_text changes.
        """
        # capitalise text
        self.text = upper_text(self.text)
        self.corrected_text = upper_text(self.corrected_text)

        # update timestamp, if necessary
        if self._state.adding or (not self._state.adding and self._loaded_values['corrected_text'] != self.corrected_text):
            self.last_updated = timezone.now()

        super().save(*args, **kwargs)


class Comment(models.Model):
    comment = models.TextField(max_length=500, blank=True)
    commenter = models.ForeignKey(User, on_delete=models.CASCADE, related_name="commenters")
    likes = models.ManyToManyField(User, related_name="comment_likes", blank=True)
    dislikes = models.ManyToManyField(User, related_name="comment_dislikes", blank=True)
    commented_at = models.DateTimeField(editable=False) 
    image = models.ForeignKey(Image, on_delete=models.CASCADE, related_name="comments")
    last_edited = models.DateTimeField(editable=True, null=True)
    
    class Meta:
        ordering = ['-commented_at']

    def __str__(self) -> str:
        return f"{textwrap.shorten(self.comment, 50, placeholder='...')} (image: {self.image.__str__()})"

    @classmethod
    def from_db(cls, db, field_names, values):
        """
        Save original values when model is loaded from database in a separate 
        attribute on the model.
        """
        instance = super().from_db(db, field_names, values)
        instance._loaded_values = dict(zip(field_names, values))
        
        return instance

    def save(self, *args, **kwargs):
        """
        Ensure date fields are the same on creation and only update
        last edited if the comment field changes.
        """
        now = timezone.now()
        if self._state.adding:
            self.commented_at = self.last_edited = now
        else:
            if self._loaded_values['comment'] != self.comment:
                self.last_edited = now
        super().save(*args, **kwargs)

    def total_likes(self) -> int:
        return self.likes.count()

    def total_dislikes(self) -> int:
        return self.dislikes.count()

    def total_reports(self) -> int:
        return self.reports.count()