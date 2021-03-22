from rest_framework import serializers
from ..models import Caption


class CaptionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Caption
        fields = '__all__'


class LimitedCaptionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Caption
        fields = [
            'id',
            'text',
            'satisfactory',
            'corrected_text',
        ]
        extra_kwargs = {
            'text': {
                'read_only': True
            }
        }