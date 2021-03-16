from django.urls import path
from ..views import SignS3Upload


# set urls for utils API
urlpatterns = [
    path('presign-s3', SignS3Upload.as_view()),
]