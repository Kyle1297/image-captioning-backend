from rest_framework import serializers
from .models import Image, Collection, Caption


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


# serializer for image caption
class ImageCaptionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Caption
        fields = [
            'id',
            'text',
            'satisfactory',
            'corrected_text',
            'reviewer',
        ]


# image serializer
class ImageSerializer(serializers.ModelSerializer):
    caption = ImageCaptionSerializer(read_only=True)

    class Meta:
        model = Image
        fields = '__all__'