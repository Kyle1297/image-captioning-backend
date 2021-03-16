from django.db import models
from django.contrib.auth.models import User
import uuid
import os


class Collection(models.Model):
    category = models.CharField("Category", unique=True, max_length=100, db_index=True)
    is_main = models.BooleanField("Main category", default=False)
    
    class Meta:
        ordering = ['category']

    def __str__(self) -> str:
        return self.category

    def clean(self):
        self.category = self.category[0].upper() + self.category[1:]

    def save(self, *args, **kwargs):
        """
        Ensure the 'category' field is always capitalized on save.
        """
        field_name = 'category'
        value = getattr(self, field_name, False)
        if value:
            setattr(self, field_name, value)
        super(Collection, self).save(*args, **kwargs)


class Image(models.Model):
    uuid = models.UUIDField("UUID", primary_key=True, unique=True, editable=False, default=uuid.uuid4)
    image = models.ImageField("Image")
    title = models.CharField("Title", db_index=True, max_length=240, blank=True)
    uploaded_at = models.DateTimeField(auto_now_add=True, editable=False) 
    is_profile_image = models.BooleanField("Profile image", default=False)
    is_private = models.BooleanField("Private image", default=False)
    collections = models.ManyToManyField(Collection, related_name="images", blank=True, default="Uncategorised")
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        ordering = ['-uploaded_at']

    def __str__(self) -> str:
        return self.title

    def save(self, *args, **kwargs):
        """
        Ensure the 'title' field is always capitalized on save.
        """
        field_name = 'title'
        value = getattr(self, field_name, False)
        if value:
            setattr(self, field_name, value.capitalize())
        super(Image, self).save(*args, **kwargs)

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


class Caption(models.Model):
    text = models.CharField("Caption", max_length=240, db_index=True)
    satisfactory = models.BooleanField("Satisfactory", default=True, null=True)
    corrected_text = models.CharField("Corrected Caption", blank=True, max_length=240, db_index=True)
    image = models.OneToOneField(Image, on_delete=models.CASCADE, related_name="caption")
    reviewer = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True)

    def __str__(self) -> str:
        if self.corrected_text:
            return self.corrected_text.capitalize()
        return self.text.capitalize()