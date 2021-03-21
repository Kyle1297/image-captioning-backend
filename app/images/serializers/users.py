from rest_framework import serializers
from ..models import Profile
from .collections import LimitedCollectionSerializer
from django.contrib.auth.models import User


class ProfileSerializer(serializers.ModelSerializer):
    liked_categories = LimitedCollectionSerializer(read_only=True, many=True)

    class Meta:
        model = Profile
        fields = [
            'id',
            'bio',
            'liked_categories',
        ]


class UserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer()

    class Meta:
        model = User
        fields = '__all__'


class LimitedUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = [
            'id',
            'username',
        ]