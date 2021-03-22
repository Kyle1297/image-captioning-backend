from .filters import ImageFilterSet
from .permissions import IsPrivateUploader
from ..models import Image, Collection, Caption, Comment
from ..serializers import ImageSerializer, CollectionSerializer, CaptionSerializer, CommentSerializer
from rest_framework import viewsets, permissions


default_http_methods = ['get', 'options', 'head', 'post', 'patch', 'delete']

class ImageViewSet(viewsets.ModelViewSet):
    permission_classes = [
        IsPrivateUploader,
    ]
    serializer_class = ImageSerializer
    filterset_class = ImageFilterSet
    http_method_names = default_http_methods

    def get_queryset(self):
        public = Image.objects.filter(is_private=False)
        if not self.request.user.is_anonymous:
            private = Image.objects.filter(uploader=self.request.user)
            return public | private
        return public

    def perform_create(self, serializer):
        serializer.save(uploader=self.request.user)


class CollectionViewSet(viewsets.ModelViewSet):
    queryset = Collection.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CollectionSerializer
    http_method_names = default_http_methods
    pagination_class = None


class CaptionViewSet(viewsets.ModelViewSet):
    queryset = Caption.objects.all()
    permission_classes = [
        IsPrivateUploader,
    ]
    serializer_class = CaptionSerializer
    http_method_names = ['options', 'post', 'patch']


class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    permission_classes = [
        permissions.AllowAny,
    ]
    serializer_class = CommentSerializer
    http_method_names = default_http_methods

    def perform_create(self, serializer):
        serializer.save(commenter=self.request.user)