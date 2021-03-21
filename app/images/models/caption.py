from django.db import models
from .image import Image


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