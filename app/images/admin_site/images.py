from .model_inlines import CaptionAddInline, CaptionChangeInline
from typing import Any
import uuid
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
        "get_collections", 
        "view_caption_link",
        'get_total_likes',
        'get_total_dislikes',
        "is_profile_image",
        "is_private",
        "view_uploader_link", 
        "uploaded_at",
    )
    list_filter = (
        "is_profile_image",
        "is_private",
    )
    search_fields = [
        "title",
        "uploader__username",
        "collections__category",
    ]

    # alter change/create view
    filter_horizontal = (
        "collections",
        "likes",
        "dislikes",
    )

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.inlines = [
            CaptionAddInline,
        ]
        self.fields = (
            "is_profile_image",
            "is_private",
            "image",
            'title',
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
            "image",
            "title",
            "collections",
            "likes",
            "dislikes",
        )
    
        return super(ImageAdmin, self).change_view(request, object_id)

    # alter default actions on save
    def save_model(self, request: Any, obj: Image, form: Any, change: bool) -> None:
        # set user and retrieve image
        obj.uploader = request.user
        filename = obj.filename()
        
        # set title if blank
        if not obj.title:
            obj.title = filename["name"].capitalize()

        # place image into correct image folder in S3 bucket
        if settings.USE_S3 == "True":
            # add uuid if not present
            if not obj.uuid:
                obj.uuid = uuid.uuid4()
            
            # handle captioned image change
            if change:
                if not obj.is_profile_image:
                    # fetch original image to check for image change
                    original_img = Image.objects.filter(uuid=obj.uuid).first()

                    # then, relocate image as appropriate
                    if original_img.image.name != form.cleaned_data["image"]:
                        original_img.image.delete(save=False)
                        self.save_captioned_image(obj, filename, original_img.is_private)
            
            # handle new
            else:
                # profile image vs captioned image
                if form.cleaned_data["is_profile_image"]:
                    obj.image.name = f"{settings.S3_USER_PROFILES_FOLDER_NAME}/{obj.uuid}{filename['extension']}"
                else:
                    self.save_captioned_image(obj, filename, form.cleaned_data["is_private"])

        return super().save_model(request, obj, form, change)
    
    # correctly save captioned image in s3 bucket folder
    def save_captioned_image(self, obj: Image, filename: dict, private: bool) -> None:
        # private vs public image
        if private: 
            obj.image.name = f"{settings.S3_CAPTIONED_IMAGES_FOLDER_NAME}/private/{obj.uuid}{filename['extension']}"
        else:
            obj.image.name = f"{settings.S3_CAPTIONED_IMAGES_FOLDER_NAME}/public/{obj.uuid}{filename['extension']}"

    # retrieve image's parent collections
    def get_collections(self, obj: Image) -> str:
        return ", ".join([collection.category for collection in obj.collections.all()])
    get_collections.short_description = "Collections"

    # allow user to view and redirect to image's publisher
    def view_uploader_link(self, obj: Image) -> str:
        url = (
            reverse("admin:auth_user_change", kwargs={'object_id': obj.uploader.id})
        )
        return format_html(f'<a href="{url}">{obj.uploader}</a>')
    view_uploader_link.short_description = "Uploader"

    # allow user to view and redirect to image's caption
    def view_caption_link(self, obj: Image) -> str:
        url = (
            reverse("admin:images_caption_change", kwargs={'object_id': obj.caption.id})
        )
        return format_html(f'<a href="{url}">{obj.caption}</a>')
    view_caption_link.short_description = "Caption"

    # show number of likes
    def get_total_likes(self, obj: Image) -> int:
        return obj.total_likes()
    get_total_likes.short_description = "Likes"

    # show number of dislikes
    def get_total_dislikes(self, obj: Image) -> int:
        return obj.total_dislikes()
    get_total_dislikes.short_description = "Dislikes"