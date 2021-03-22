from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from .models import Profile
from images.serializers import LimitedCollectionSerializer
from django.contrib.auth.models import User


class ProfileSerializer(serializers.ModelSerializer):
    liked_categories = LimitedCollectionSerializer(many=True)

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
        fields = [
            'id',
            'username',
            'email',
            'profile',
        ]


class LimitedUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = [
            'id',
            'username',
        ]


class RegisterSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'email',
            'password',
        ]
        extra_kwargs = {
            'password': {
                'write_only': True
            }
        }
    
    def create(self, validated_data):
        user = User.objects.create_user(validated_data['username'],
                                        validated_data['email'],
                                        validated_data['password'])
        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)
        if user and user.is_active:
            return user
        raise serializers.ValidationError("Hmmm... we don't seem to have those credentials. Please try again.")