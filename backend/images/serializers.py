from rest_framework import serializers
from .models import *


class ImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = Image
        fields = ('pk', 'filename', 'title', 'uuid', 'uploaded_at', 'is_profile_image', 'caption', 'collections', 'user')