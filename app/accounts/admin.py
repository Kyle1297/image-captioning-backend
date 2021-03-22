from django.contrib import admin
from .models import Profile
from typing import Any
from django.contrib.auth.models import User


class ProfileAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "user",
        "bio",
        "get_liked_categories",
    )
    search_fields = [
        "user__username",
    ]

    # alter change/create view
    filter_horizontal = (
        "liked_categories",
    )
    fields = (
        "user",
        "bio",
        "liked_categories",
    )
    
    # retrieve user's liked collections
    def get_liked_categories(self, obj: Profile) -> str:
        return ", ".join([collection.category for collection in obj.liked_categories.all()])
    get_liked_categories.short_description = "Liked collections"

    # remore redundant values from user selection
    def get_form(self, request: Any, obj: Profile, change: bool, **kwargs: Any) -> None:
        form = super().get_form(request, obj=obj, change=change, **kwargs)
        unused = []
        if change:
            unused.append((obj.user.id, obj.user.username))
        unused.extend([(user.id, user.username) for user in User.objects.filter(profile__isnull=True)])
        form.base_fields['user'].choices = unused
        return form


# register admin models
admin.site.register(Profile, ProfileAdmin)