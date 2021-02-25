from .models import *
from .serializers import *
from rest_framework import viewsets, permissions


# images API
class ImageViewSet(viewsets.ModelViewSet):
    queryset = Image.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = ImageSerializer


# image collections API
class CollectionViewSet(viewsets.ModelViewSet):
    queryset = Collection.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CollectionSerializer


# image captions API
class CaptionViewSet(viewsets.ModelViewSet):
    queryset = Caption.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CaptionSerializer