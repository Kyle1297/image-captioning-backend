from django.db import models


class Caption(models.Model):
    generated_text = models.TextField("Generated Caption", editable=False)
    satisfactory = models.BooleanField("Satisfactory", null=True)
    corrected_text = models.TextField("Corrected Caption", blank=True)


class Collection(models.Model):
    category = models.CharField("Category", unique=True)

    class Meta:
        ordering = ['category']

    def __str__(self) -> str:
        return self.category


class Image(models.Model):
    filename = models.TextField("Filename")
    title = models.CharField("Title", db_index=True)
    uuid = models.UUIDField("UUID", primary_key=True, unique=True, editable=False)
    uploaded_at = models.DateTimeField(auto_now_add=True, editable=False) 
    is_profile_image = models.BooleanField(default=False)
    caption = models.ForeignKey(Caption, on_delete=models.SET_DEFAULT, blank=True)
    collections = models.ManyToManyField(Collection, related_name="images")
    user = models.ForeignKey('User', on_delete=models.CASCADE)

    class Meta:
        ordering = ['uploaded_at', 'title']

    def __str__(self) -> str:
        return self.title