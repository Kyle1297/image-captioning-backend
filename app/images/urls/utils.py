from django.urls import path
from ..views import SignS3Upload, CaptionSNS


# set urls for utils API
urlpatterns = [
    path('presign-s3', SignS3Upload.as_view(), name="presign-s3"),
    path('caption-sns/<str:uuid>/', CaptionSNS.as_view()),
]