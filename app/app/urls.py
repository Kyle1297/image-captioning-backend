from django.contrib import admin
from django.urls import path, re_path
from images import views
from django.conf.urls import url

urlpatterns = [
    path('admin/', admin.site.urls),
    re_path(r'^api/images/$', views.images_list),
    re_path(r'^api/images/([0-9])$', views.image_details),
]

from django.conf import settings
from django.conf.urls.static import static

from images.views import image_upload

urlpatterns = [
    path("", image_upload, name="upload"),
    path("admin/", admin.site.urls),
]

if bool(settings.DEBUG):
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)