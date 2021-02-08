from typing import Any, Optional, Dict
from django.contrib import admin
from django.http import HttpRequest, HttpResponse
from .models import *
import os


class ImageAdmin(admin.ModelAdmin):
    list_display = (
        "title",  
        "get_collections", 
        "is_profile_image",
        "user", 
        "uploaded_at",
    )
    list_filter = (
        "collections",
        "user",
        "is_profile_image",
    )
    search_fields = [
        "title",
    ]
    filter_horizontal = (
        "collections",
    )

    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
        "is_profile_image",
        "image",
        "collections",
        )
        return super(ImageAdmin, self).add_view(request)

    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "is_profile_image",
            "image",
            "title",
            "collections",
        )
        return super(ImageAdmin, self).change_view(request, object_id)

    def save_model(self, request: Any, obj: Image, form: Any, change: Any) -> None:
        obj.user = request.user
        if not obj.title:
            filename = form.cleaned_data["image"].name
            obj.title = os.path.splitext(filename)[0]
        return super().save_model(request, obj, form, change)

    def get_collections(self, obj: Image):
        return ", ".join([collection.category for collection in obj.collections.all()])
    get_collections.short_description = "Collections"


class CaptionAdmin(admin.ModelAdmin):
    list_display = (
        "text",
        "satisfactory",
        "image",
        "corrected_text",
    )
    list_filter = (
        "satisfactory",
    )
    search_fields = [
        "text",
        "corrected_text",
        "image__title",
    ]

    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
            "text",
            "image",
        )
        self.readonly_fields = ()
        return super(CaptionAdmin, self).add_view(request)

    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "text",
            "satisfactory",
            "corrected_text",
            "image",
        )
        self.readonly_fields = (
            "text",
        )
        return super(CaptionAdmin, self).change_view(request, object_id)


class CollectionAdmin(admin.ModelAdmin):
    list_display = (
        "category",
        "description",
    )
    search_fields = [
        "category",
    ]


admin.site.register(Collection, CollectionAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Caption, CaptionAdmin)