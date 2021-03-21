from rest_framework import serializers
from ..models import Collection


class CollectionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Collection
        fields = '__all__'


class LimitedCollectionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Collection
        fields = [
            'id',
            'category',
        ]