from rest_framework import serializers
from .models import *


# image serializer
class ImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = Image
        fields = '__all__'


# image collections serializer
class CollectionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Collection
        fields = '__all__'


# image captions serializer
class CaptionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Caption
        fields = '__all__'