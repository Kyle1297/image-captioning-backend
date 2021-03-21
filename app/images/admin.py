from django.contrib import admin
from .admin_site import *
from .models import *


# add models to admin site
admin.site.register(Collection, CollectionAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Caption, CaptionAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Profile, ProfileAdmin)