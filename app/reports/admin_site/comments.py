from django.utils import timezone
from typing import Any
from ..models import CommentReport
from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.http import HttpRequest, HttpResponse

class CommentReportAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "id",
        "type",
        "view_comment_link",
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
		"comment__image__title",
        "reviewer__username",
		"type",
    ]

    # alter the creation view
    def add_view(self, request: HttpRequest) -> HttpResponse:
        self.fields = (
            "comment",
            "type",
        )
        return super(CommentReportAdmin, self).add_view(request)

   # alter the change view
    def change_view(self, request: HttpRequest, object_id: str) -> HttpResponse:
        self.fields = (
            "solved",
            "type",
            "comments",
        )
        return super(CommentReportAdmin, self).change_view(request, object_id)

    # alter default actions on save
    def save_model(self, request: Any, obj: CommentReport, form: Any, change: bool) -> None:
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
    def view_comment_link(self, obj: CommentReport) -> str:
        url = (
            reverse("admin:images_comment_change", kwargs={'object_id': obj.comment.id})
        )
        return format_html(f'<a href="{url}">{obj.comment}</a>')
    view_comment_link.short_description = "Comment"

    # allow user to view and redirect to comment's reporter
    def view_user_link(self, obj: CommentReport) -> str:
        if obj.user:
            url = (
                reverse("admin:auth_user_change", kwargs={'object_id': obj.user.id})
            )
            return format_html(f'<a href="{url}">{obj.user}</a>')
    view_user_link.short_description = "Reporter"

    # allow user to view and redirect to report's reviewer
    def view_reviewer_link(self, obj: CommentReport) -> str:
        if obj.reviewer:
            url = (
                reverse("admin:auth_user_change", kwargs={'object_id': obj.reviewer.id})
            )
            return format_html(f'<a href="{url}">{obj.user}</a>')
    view_reviewer_link.short_description = "Reviewer"