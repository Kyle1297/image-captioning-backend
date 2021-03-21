import uuid, os
from django.db import models
from .collection import Collection
from django.contrib.auth.models import User


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