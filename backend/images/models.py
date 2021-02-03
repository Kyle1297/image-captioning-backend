from django.db import models


class Caption(models.Model):
    generated_text = models.TextField("Generated Caption", editable=False)
    satisfactory = models.BooleanField("Satisfactory", null=True)
    corrected_text = models.TextField("Corrected Caption", blank=True)


class Collection(models.Model):
    category = models.CharField("Category", unique=True, max_length=100)

    class Meta:
        ordering = ['category']

    def __str__(self) -> str:
        return self.category


class Userx(models.Model):
    full_name = models.CharField("Full name", max_length=240)
    email = models.EmailField("Email")

    def __str__(self) -> str:
        return self.full_name


class Image(models.Model):
    filename = models.CharField("Filename", max_length=240)
    title = models.CharField("Title", db_index=True, max_length=240)
    uuid = models.UUIDField("UUID", primary_key=True, unique=True, editable=False)
    uploaded_at = models.DateTimeField(auto_now_add=True, editable=False) 
    is_profile_image = models.BooleanField(default=False)
    caption = models.ForeignKey(Caption, on_delete=models.SET(""), blank=True)
    collections = models.ManyToManyField(Collection, related_name="images")
    user = models.ForeignKey(Userx, on_delete=models.CASCADE)

    class Meta:
        ordering = ['uploaded_at', 'title']

    def __str__(self) -> str:
        return self.title