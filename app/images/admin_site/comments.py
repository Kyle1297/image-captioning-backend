from ..models import Comment
from django.contrib import admin
from typing import Any
from django.http import HttpRequest, HttpResponse
from django.urls import reverse
from django.utils.html import format_html


class CommentAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "comment",
        "view_image_link",
        'get_total_likes',
        'get_total_dislikes',
        'get_total_reports',
        "view_commenter_link",
        "last_edited",
        "commented_at",
    )
    search_fields = [
        "comment",
        "commenter__username",
        "image__title",
    ]

    # alter change/create view
    filter_horizontal = (
        "likes",
        "dislikes",
    )

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
            "comment",
            "image",
        )
        return super(CommentAdmin, self).add_view(request)

   # alter the change view
    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "comment",
            "image",
            "likes",
            "dislikes",
        )
        return super(CommentAdmin, self).change_view(request, object_id)

    # alter default actions on save
    def save_model(self, request: Any, obj: Comment, form: Any, change: bool) -> None:
        # set commenter
        obj.commenter = request.user
        
        return super().save_model(request, obj, form, change)

    # allow users to view and redirect to the caption's image
    def view_image_link(self, obj: Comment) -> str:
        url = (
            reverse("admin:images_image_change", kwargs={'object_id': obj.image.uuid})
        )
        return format_html(f'<a href="{url}">{obj.image}</a>')
    view_image_link.short_description = "Image"

    # allow user to view and redirect to comment's creator
    def view_commenter_link(self, obj: Comment) -> str:
        url = (
            reverse("admin:auth_user_change", kwargs={'object_id': obj.commenter.id})
        )
        return format_html(f'<a href="{url}">{obj.commenter}</a>')
    view_commenter_link.short_description = "Commenter"

    # show number of likes
    def get_total_likes(self, obj: Comment) -> int:
        return obj.total_likes()
    get_total_likes.short_description = "Likes"

    # show number of dislikes
    def get_total_dislikes(self, obj: Comment) -> int:
        return obj.total_dislikes()
    get_total_dislikes.short_description = "Dislikes"

    # show number of reports
    def get_total_reports(self, obj: Comment) -> int:
        return obj.total_reports()
    get_total_reports.short_description = "Reports"