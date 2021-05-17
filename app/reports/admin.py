from django.contrib import admin
from .admin_site import CommentReportAdmin, ImageReportAdmin
from .models import CommentReport, ImageReport


# add models to admin site
admin.site.register(CommentReport, CommentReportAdmin)
admin.site.register(ImageReport, ImageReportAdmin)