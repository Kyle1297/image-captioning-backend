from typing import Any
from django.contrib import admin
from django.http import HttpRequest, HttpResponse
from .models import *
from django.conf import settings


class ImageAdmin(admin.ModelAdmin):
    # set list display and functionality
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

    # alter change/create view
    filter_horizontal = (
        "collections",
    )

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
        "is_profile_image",
        'title',
        "image",
        "collections",
        )
        return super(ImageAdmin, self).add_view(request)

    # alter the change view
    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "title",
            "image",
            "collections",
        )
        return super(ImageAdmin, self).change_view(request, object_id)

    # alter default actions on save
    def save_model(self, request: Any, obj: Image, form: Any, change: bool) -> None:
        # set user and retrieve image
        obj.user = request.user
        filename = obj.filename()
        
        # set title if blank
        if not obj.title:
            obj.title = filename["name"].capitalize()

        # place image into correct image folder in S3 bucket
        if settings.USE_S3 == "True" and not change:
            if form.cleaned_data["is_profile_image"]:
                obj.image.name = f"{settings.S3_USER_PROFILES_FOLDER_NAME}/{obj.uuid}{filename['extension']}"
            else:
                obj.image.name = f"{settings.S3_CAPTIONED_IMAGES_FOLDER_NAME}/{obj.uuid}{filename['extension']}"
 
        return super().save_model(request, obj, form, change)

    # retrieve collections the image belongs to
    def get_collections(self, obj: Image):
        return ", ".join([collection.category for collection in obj.collections.all()])
    get_collections.short_description = "Collections"


class CaptionAdmin(admin.ModelAdmin):
    # set list display and functionality
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

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
            "text",
            "image",
        )
        self.readonly_fields = ()
        return super(CaptionAdmin, self).add_view(request)

   # alter the change view
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
    # set list display and functionality
    list_display = (
        "category",
        "description",
    )
    search_fields = [
        "category",
    ]


# add models to admin site
admin.site.register(Collection, CollectionAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Caption, CaptionAdmin)