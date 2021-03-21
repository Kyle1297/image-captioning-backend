from django_filters import FilterSet
from ..models import Image


class ImageFilterSet(FilterSet):

   class Meta:
       model = Image
       fields = [
           'uploaded_at',
           'is_profile_image',
           'is_private',
           'uploader__username',
           'collections__category',
           'collections__is_main',
       ]