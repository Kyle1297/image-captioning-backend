from django.contrib import admin
from django.urls import path, re_path
from images import views
from django.conf.urls.static import static
from django.conf import settings


urlpatterns = [
    path('admin/', admin.site.urls, name="admin"),
    re_path(r'^api/images/$', views.images_list, name="images_list"),
    re_path(r'^api/images/([0-9])$', views.image_details, name="image_details"),
]