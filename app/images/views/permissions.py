from ..models import Image
from rest_framework import permissions


class IsPrivateUploader(permissions.BasePermission): 
    """
    Only person who uploaded private image can view.

    Everyone can view public images.
    """
    message = 'You must have uploaded this image.'

    def has_object_permission(self, request, view, obj):
        if type(obj) == Image:
            return not obj.is_private or (obj.is_private and obj.uploader == request.user)
        else:
            return not obj.image.is_private or (obj.image.is_private and obj.image.uploader == request.user)