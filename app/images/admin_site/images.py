from .model_inlines import CaptionAddInline, CaptionChangeInline
from typing import Any
from django.contrib import admin
from django.http import HttpRequest, HttpResponse
from ..models import Image
from django.urls import reverse
from django.utils.html import format_html


class ImageAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "title",  
        "get_collections", 
        "view_caption_link",
        'get_total_likes',
        'get_total_dislikes',
        'views',
        'get_total_reports',
        'downloads',
        "is_profile_image",
        "is_private",
        "width",
        "height",
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

    # remove image creation, can only be done on frontend
    def has_add_permission(self, request: HttpRequest) -> bool:
        return False

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

        return super().save_model(request, obj, form, change)

    # retrieve image's parent collections
    def get_collections(self, obj: Image) -> str:
        return ", ".join([collection.category for collection in obj.collections.all()])
    get_collections.short_description = "Collections"

    # allow user to view and redirect to image's publisher
    def view_uploader_link(self, obj: Image) -> str:
        if obj.uploader:
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

    # show number of reports
    def get_total_reports(self, obj: Image) -> int:
        return obj.total_reports()
    get_total_reports.short_description = "Reports"