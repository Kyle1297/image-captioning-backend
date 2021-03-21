from ..models import Caption, Image
from django.contrib import admin
from typing import Any
from django.http import HttpRequest, HttpResponse
from django.urls import reverse
from django.utils.html import format_html


class CaptionAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "text",
        "satisfactory",
        "view_image_link",
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
        return super(CaptionAdmin, self).add_view(request)

   # alter the change view
    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "satisfactory",
            "text",
            "corrected_text",
            "image",
        )
        return super(CaptionAdmin, self).change_view(request, object_id)

    # allow users to view and redirect to the caption's image
    def view_image_link(self, obj: Caption) -> str:
        url = (
            reverse("admin:images_image_change", kwargs={'object_id': obj.image.uuid})
        )
        return format_html(f'<a href="{url}">{obj.image}</a>')
    view_image_link.short_description = "Image"

    # remore redundant values from image selection
    def get_form(self, request: Any, obj: Caption, change: bool, **kwargs: Any) -> None:
        form = super().get_form(request, obj=obj, change=change, **kwargs)
        unused = []
        if change:
            unused.append((obj.image.uuid, obj.image.title))
        unused.extend([(image.uuid, image.title) for image in Image.objects.filter(caption__isnull=True)])
        form.base_fields['image'].choices = unused
        return form