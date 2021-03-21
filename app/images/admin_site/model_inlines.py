from django.contrib import admin
from ..models import Caption


class CaptionAddInline(admin.TabularInline):
    model = Caption
    fields = (
        "text",
    )


class CaptionChangeInline(admin.TabularInline):
    model = Caption
    fields = (
        "text",
        "satisfactory",
        "corrected_text",
    )