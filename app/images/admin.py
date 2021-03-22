from django.contrib import admin
from .admin_site import CollectionAdmin, ImageAdmin, CaptionAdmin, CommentAdmin
from .models import Collection, Image, Caption, Comment


# add models to admin site
admin.site.register(Collection, CollectionAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Caption, CaptionAdmin)
admin.site.register(Comment, CommentAdmin)