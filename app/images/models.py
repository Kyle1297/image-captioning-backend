from django.db import models
from django.contrib.auth.models import User
import uuid
import os


class Collection(models.Model):
    category = models.CharField("Category", unique=True, max_length=100, db_index=True)
    description = models.CharField("Description", max_length=240, blank=True)

    class Meta:
        ordering = ['category']

    def __str__(self) -> str:
        return self.category.capitalize()


class Image(models.Model):
    image = models.ImageField("Image")
    title = models.CharField("Title", db_index=True, max_length=240, blank=True)
    uuid = models.UUIDField("UUID", primary_key=True, unique=True, editable=False, default=uuid.uuid4)
    uploaded_at = models.DateTimeField(auto_now_add=True, editable=False) 
    is_profile_image = models.BooleanField("Profile image", default=False)
    collections = models.ManyToManyField(Collection, related_name="images")
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        ordering = ['-uploaded_at']

    def __str__(self) -> str:
        return self.title

    def filename(self) -> dict:
        name, extension = os.path.splitext(self.image.name)
        return { 
            "name": name,
            "extension": extension,
        }


class Caption(models.Model):
    text = models.CharField("Caption", max_length=240, db_index=True)
    satisfactory = models.BooleanField("Satisfactory", default=True, null=True)
    corrected_text = models.CharField("Corrected Caption", blank=True, max_length=240, db_index=True)
    image = models.OneToOneField(Image, on_delete=models.CASCADE)

    def __str__(self) -> str:
        if self.corrected_text:
            return self.corrected_text.capitalize()
        return self.text.capitalize()