from images.models import Comment, Image
from django.db import models
from django.contrib.auth.models import User
from django.db import models

class BaseReport(models.Model): 
    LEGAL = 'LEGAL'
    VIOLENT = 'VIOLENT' 
    HATEFUL = 'HATEFUL'
    SEXUAL = 'SEXUAL'
    SPAM = 'SPAM'
    CAPTION = 'CAPTION'
    HARASSMENT = 'HARASSMENT'
    OTHER = 'OTHER'

    REPORTING_CHOICES = {
        "Comment": [
            (VIOLENT, 'Violent or repulsive'), 
            (HATEFUL, 'Hateful or abusive'),
            (SEXUAL, 'Sexually explicit material'),
            (SPAM, 'Spam or misleading'),
            (HARASSMENT, 'Bullying or harassment'),
            (OTHER, 'Other'),
        ],
        "Image": [
            (LEGAL, 'Infringes my rights'),
            (VIOLENT, 'Violent or repulsive'), 
            (HATEFUL, 'Hateful or abusive'),
            (SEXUAL, 'Sexually explicit material'),
            (SPAM, 'Spam or misleading'),
            (CAPTION, 'Caption issue'),
            (HARASSMENT, 'Bullying or harassment'),
            (OTHER, 'Other'),
        ],
    }
    
    comments = models.TextField("Comments", max_length=500, blank=True)
    reviewed = models.BooleanField("Reviewed", default=False)
    solved = models.BooleanField("Solved", default=False)
    reported_at = models.DateTimeField(auto_now_add=True, editable=False) 
    reviewed_at = models.DateTimeField(null=True)
    solved_at = models.DateTimeField(null=True)  
    
    class Meta:
        abstract = True


class ImageReport(BaseReport):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="image_reporters")
    image = models.ForeignKey(Image, on_delete=models.CASCADE, related_name="reports")
    type = models.CharField(
        max_length=20,
        choices=BaseReport.REPORTING_CHOICES['Image']
    )
    reviewer = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True, related_name="image_reviewers")

    class Meta:
      verbose_name = "Image"

    def __str__(self) -> str:
        return f"{self.type} report {self.id} (image: {self.image.__str__()}"


class CommentReport(BaseReport):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="comment_reporters")
    comment = models.ForeignKey(Comment, on_delete=models.CASCADE, related_name="reports")
    type = models.CharField(
        max_length=20,
        choices=BaseReport.REPORTING_CHOICES['Comment']
    )
    reviewer = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True, related_name="comment_reviewers")

    class Meta:
      verbose_name = "Comment"

    def __str__(self) -> str:
        return f"{self.type} report {self.id} (comment: {self.comment.__str__()})"
