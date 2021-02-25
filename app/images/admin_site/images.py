from .model_inlines import CaptionAddInline, CaptionChangeInline
from typing import Any
from django.contrib import admin
from django.http import HttpRequest, HttpResponse
from ..models import Image
from django.urls import reverse
from django.utils.html import format_html
from django.conf import settings


class ImageAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "title",  
        "get_parent_collections", 
        "view_caption_link",
        "is_profile_image",
        "is_private",
        "view_user_link", 
        "uploaded_at",
    )
    list_filter = (
        "collections",
        "is_profile_image",
        "is_private",
    )
    search_fields = [
        "title",
        "user",
        "collections",
    ]

    # alter change/create view
    filter_horizontal = (
        "collections",
    )

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.inlines = [
            CaptionAddInline,
        ]
        self.fields = (
            "is_profile_image",
            "is_private",
            'title',
            "image",
            "collections",
        )
        return super(ImageAdmin, self).add_view(request)

    # alter the change view
    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        # show caption creation or edit inline, based on whether image has caption or not
        if Image.objects.filter(uuid=object_id, caption__isnull=False):
            self.inlines = [
                CaptionChangeInline,
            ]
        else:
            self.inlines = [
                CaptionAddInline,
            ]

        self.fields = (
            "is_private",
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

    # retrieve image's parent collections
    def get_parent_collections(self, obj: Image) -> str:
        return ", ".join([collection.category for collection in obj.collections.all()])
    get_parent_collections.short_description = "Collections"

    # allow user to view and redirect to image's publisher
    def view_user_link(self, obj: Image) -> str:
        url = (
            reverse("admin:auth_user_change", kwargs={'object_id': obj.user.id})
        )
        return format_html(f'<a href="{url}">{obj.user}</a>')
    view_user_link.short_description = "User"

    # allow user to view and redirect to image's caption
    def view_caption_link(self, obj: Image) -> str:
        url = (
            reverse("admin:images_caption_change", kwargs={'object_id': obj.caption.id})
        )
        return format_html(f'<a href="{url}">{obj.caption}</a>')
    view_caption_link.short_description = "Caption"