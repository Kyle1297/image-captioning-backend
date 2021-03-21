from django.db import models
from .image import Image
from django.contrib.auth.models import User


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