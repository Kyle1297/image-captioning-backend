import uuid, os
from django.db import models
from django.contrib.auth.models import User
from django.db import models


class Collection(models.Model):
    category = models.CharField("Category", unique=True, max_length=100, db_index=True)
    is_main = models.BooleanField("Main category", default=False)
    
    class Meta:
        ordering = ['category']

    def __str__(self) -> str:
        return self.category

    def clean(self):
        """
        Ensure the 'category' field is always capitalized.
        """
        self.category = self.category[0].upper() + self.category[1:]


class Image(models.Model):
    uuid = models.UUIDField("UUID", primary_key=True, unique=True, editable=False, default=uuid.uuid4)
    image = models.ImageField("Image")
    title = models.CharField("Title", db_index=True, max_length=240, blank=True)
    uploaded_at = models.DateTimeField(auto_now_add=True, editable=False) 
    is_profile_image = models.BooleanField("Profile image", default=False)
    is_private = models.BooleanField("Private image", default=False)
    collections = models.ManyToManyField(Collection, related_name="images", blank=True, default="Uncategorised")
    uploader = models.ForeignKey(User, on_delete=models.CASCADE, related_name="image_uploaders")
    likes = models.ManyToManyField(User, related_name="image_likes", blank=True)
    dislikes = models.ManyToManyField(User, related_name="image_dislikes", blank=True)

    class Meta:
        ordering = ['-uploaded_at']

    def __str__(self) -> str:
        return self.title

    def clean(self):
        """
        Ensure the 'title' field is always capitalized on save.
        """
        self.title = self.title[0].upper() + self.title[1:]

    def delete(self):
        """ 
        Remove image from s3 upon deletion.
        """
        self.image.delete(save=False)
        super().delete()

    def filename(self) -> dict:
        """
        Retrieves a image file's extension and filename without
        its extension attached to it.
        """
        name, extension = os.path.splitext(self.image.name)
        return { 
            "name": name,
            "extension": extension,
        }

    def total_likes(self) -> int:
        return self.likes.count()

    def total_dislikes(self) -> int:
        return self.dislikes.count()


class Caption(models.Model):
    text = models.CharField("Caption", max_length=240, db_index=True)
    satisfactory = models.BooleanField("Satisfactory", default=True, null=False, blank=False)
    corrected_text = models.CharField("Corrected Caption", blank=True, max_length=240, db_index=True)
    image = models.OneToOneField(Image, on_delete=models.CASCADE, related_name="caption")

    def __str__(self) -> str:
        if self.corrected_text:
            return self.corrected_text.capitalize()
        return self.text.capitalize()

    def clean(self):
        """
        Ensure the 'text' and 'corrected_text' fields are always 
        capitalized.
        """
        self.text = self.text[0].upper() + self.text[1:]
        self.corrected_text = self.corrected_text[0].upper() + self.corrected_text[1:]


class Comment(models.Model):
    comment = models.TextField(max_length=500, blank=True)
    commenter = models.ForeignKey(User, on_delete=models.CASCADE, related_name="comment_commenters")
    likes = models.ManyToManyField(User, related_name="comment_likes", blank=True)
    dislikes = models.ManyToManyField(User, related_name="comment_dislikes", blank=True)
    commented_at = models.DateTimeField(auto_now_add=True, editable=False) 
    image = models.ForeignKey(Image, on_delete=models.CASCADE, related_name="comments")
    
    class Meta:
        ordering = ['-commented_at']

    def __str__(self) -> str:
        return self.comment

    def total_likes(self) -> int:
        return self.likes.count()

    def total_dislikes(self) -> int:
        return self.dislikes.count()