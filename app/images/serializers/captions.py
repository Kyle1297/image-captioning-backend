from rest_framework import serializers
from ..models import Caption


class CaptionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Caption
        fields = '__all__'
        extra_kwargs = {
            'image': {
                'write_only': True,
                'required': False,
            }
        }