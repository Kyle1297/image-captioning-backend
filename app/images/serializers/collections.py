from rest_framework import serializers
from ..models import Collection


class CollectionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Collection
        fields = '__all__'
        extra_kwargs = {
            'creator': {
                'write_only': True,
                'required': True,
            }
        }