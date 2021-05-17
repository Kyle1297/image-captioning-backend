from django.contrib import admin
from .models import Profile
from typing import Any
from django.http import HttpRequest
from django.contrib.auth.models import User


class ProfileAdmin(admin.ModelAdmin):
    # set list display and functionality
    list_display = (
        "user",
        "bio",
        "location",
        "get_interests",
        'get_total_following',
        'get_total_followers',
    )
    search_fields = [
        "user__username",
    ]

    # alter change/create view
    filter_horizontal = (
        "interests",
        "following",
    )
    fields = (
        "user",
        "location",
        "bio",
        "interests",
        "following",
    )

    # remove profile creation, created automatically when user is created
    def has_add_permission(self, request: HttpRequest) -> bool:
        return False
    
    # retrieve user's liked collections
    def get_interests(self, obj: Profile) -> str:
        return ", ".join([collection.category for collection in obj.interests.all()])
    get_interests.short_description = "Interests"

    # remore redundant values from user and following selection
    def get_form(self, request: Any, obj: Profile, change: bool, **kwargs: Any) -> None:
        # prevent user from following self
        form = super().get_form(request, obj=obj, change=change, **kwargs)
        form.base_fields['following']._queryset = form.base_fields['following']._queryset.exclude(id=obj.user.id)

        # remove values from user selection
        unused = []
        if change:
            unused.append((obj.user.id, obj.user.username))
        unused.extend([(user.id, user.username) for user in User.objects.filter(profile__isnull=True)])
        form.base_fields['user'].choices = unused

        return form

    # show number of following
    def get_total_following(self, obj: Profile) -> int:
        return obj.total_following()
    get_total_following.short_description = "Following"

    # show number of followers
    def get_total_followers(self, obj: Profile) -> int:
        return obj.total_followers()
    get_total_followers.short_description = "Followers"

# register admin models
admin.site.register(Profile, ProfileAdmin)