from .filters import ImageFilterSet
from .permissions import IsPrivateUploader
from ..models import Image, Collection, Caption, Comment
from ..serializers import ImageSerializer, CollectionSerializer, CaptionSerializer, UserSerializer, CommentSerializer
from rest_framework import viewsets, permissions
from django.contrib.auth.models import User


# images API
class ImageViewSet(viewsets.ModelViewSet):
    queryset = Image.objects.all()
    permission_classes = (
        IsPrivateUploader,
    )
    serializer_class = ImageSerializer
    filterset_class = ImageFilterSet

    def perform_create(self, serializer):
        serializer.save(uploader=self.request.user)


# image collections API
class CollectionViewSet(viewsets.ModelViewSet):
    queryset = Collection.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CollectionSerializer
    pagination_class = None


# image captions API
class CaptionViewSet(viewsets.ModelViewSet):
    queryset = Caption.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CaptionSerializer


# image comments API
class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CommentSerializer

    def perform_create(self, serializer):
        serializer.save(commenter=self.request.user)

# users API
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = UserSerializer