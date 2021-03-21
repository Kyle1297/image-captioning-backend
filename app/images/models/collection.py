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