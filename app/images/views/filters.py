import json
from django_filters import FilterSet, CharFilter
from app.types import ModelType
from ..models import Collection, Comment, Image
from django.db.models import Q


class ImageFilterSet(FilterSet):
    search = CharFilter(method='search_filter')
    uploader = CharFilter(method='uploader_filter')
    collections = CharFilter(method='collections_filter')
    liked = CharFilter(method='liked_filter')

    class Meta:
        model = Image
        fields = [
            'is_profile_image',
            'is_private',
        ]

    def search_filter(self, queryset: ModelType[Image], name, value: str):
        return queryset.filter(
            Q(title__icontains=value) |  
            Q(collections__category__icontains=value) |
            Q(uploader__username__contains=value) |
            Q(caption__text__icontains=value) |
            Q(caption__corrected_text__icontains=value)
        ).order_by('uuid').distinct('uuid')

    def uploader_filter(self, queryset: ModelType[Image], name, value: int):
        return queryset.filter(
            Q(uploader=value)
        ).order_by('uuid').distinct('uuid')

    def collections_filter(self, queryset: ModelType[Image], name, value: str):
        value = json.loads(value)
        return queryset.filter(
            Q(collections__category__in=value)
        ).order_by('uuid').distinct('uuid')

    def liked_filter(self, queryset: ModelType[Image], name, value: int):
        return queryset.filter(
            Q(likes__id=value)
        ).order_by('uuid').distinct('uuid')


class CollectionFilterSet(FilterSet):

    class Meta:
        model = Collection
        fields = [
            'creator',
            'is_main',
        ]

class CommentFilterSet(FilterSet):

    class Meta:
        model = Comment
        fields = [
            'commenter',
            'image',
        ]