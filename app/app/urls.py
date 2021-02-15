from django.contrib import admin
from django.urls import path, re_path
from images import views
from django.conf.urls import url

urlpatterns = [
    path('admin/', admin.site.urls),
    re_path(r'^api/images/$', views.images_list),
    re_path(r'^api/images/([0-9])$', views.image_details),
]