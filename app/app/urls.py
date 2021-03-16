from django.contrib import admin
from django.urls import path, include
from images.urls import images, utils


urlpatterns = [
    path('admin/', admin.site.urls, name="admin"),
    path('api_v1/images/', include((images, "images"), namespace="images")),
    path('api_v1/utils/', include((utils, "utils"), namespace="utils")),
]