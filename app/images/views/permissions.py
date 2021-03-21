from rest_framework import permissions

class IsPrivateUploader(permissions.BasePermission): 
    """
    Only person who uploaded private image can view.

    Everyone can view public images.
    """
    def has_permission(self, request, view):
        # check if the request is for a single object
        if view.lookup_url_kwarg in view.kwargs:
            return True
        return True
    def has_object_permission(self, request, view, obj):
        message = 'You must have uploaded this image.'
        return False
        #return not obj.is_private or (obj.is_private and obj.uploader == request.user)