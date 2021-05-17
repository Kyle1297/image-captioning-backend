from django.utils import timezone
from typing import Any
from ..models import ImageReport
from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.http import HttpRequest, HttpResponse

class ImageReportAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "id",
        "type",
        "view_image_link",
        "view_user_link",
        "reviewed",
        "solved",
        "view_reviewer_link",
        "comments",
        "solved_at",
        "reviewed_at",
        "reported_at",
    )
    list_filter = (
		"type",
        "reviewed",
        "solved",
    )
    search_fields = [
        "user__username",
        "reviewer__username",
		"image__title",
		"type",
    ]

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
            "image",
            "type",
        )
        return super(ImageReportAdmin, self).add_view(request)

   # alter the change view
    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "solved",
            "type",
            "comments",
        )
        return super(ImageReportAdmin, self).change_view(request, object_id)

    # alter default actions on save
    def save_model(self, request: Any, obj: ImageReport, form: Any, change: bool) -> None:
        if change:
            # handle reviewer
            obj.reviewer = request.user
            if not obj.reviewed:
                obj.reviewed = True
                obj.reviewed_at = timezone.now()

            # handle solver
            if obj.solved:
                obj.solved_at = timezone.now()
            else:
                obj.solved_at = None
        else:
            # handle reporter
            obj.user = request.user

        return super().save_model(request, obj, form, change)

    # allow users to view and redirect to the caption's image
    def view_image_link(self, obj: ImageReport) -> str:
        url = (
            reverse("admin:images_image_change", kwargs={'object_id': obj.image.uuid})
        )
        return format_html(f'<a href="{url}">{obj.image}</a>')
    view_image_link.short_description = "Image"

    # allow user to view and redirect to image's reporter
    def view_user_link(self, obj: ImageReport) -> str:
        if obj.user:
            url = (
                reverse("admin:auth_user_change", kwargs={'object_id': obj.user.id})
            )
            return format_html(f'<a href="{url}">{obj.user}</a>')
    view_user_link.short_description = "Reporter"

    # allow user to view and redirect to report's reviewer
    def view_reviewer_link(self, obj: ImageReport) -> str:
        if obj.reviewer:
            url = (
                reverse("admin:auth_user_change", kwargs={'object_id': obj.reviewer.id})
            )
            return format_html(f'<a href="{url}">{obj.user}</a>')
    view_reviewer_link.short_description = "Reviewer"