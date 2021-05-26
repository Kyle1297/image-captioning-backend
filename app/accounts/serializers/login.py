from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth import password_validation as validators
from django.core import exceptions


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

    def validate_email(self, email):
        """
        Validate email on registration.
        """
        
        # check for missing email
        if email:
            return email
        raise serializers.ValidationError(["This field may not be blank."])
        

    def validate(self, data):
        """
        Validate password on registration.
        """
        
        # retrieve user and their password
        user = User(**data)
        password = data['password']

        # validate password and catch exception
        errors = {}
        try:
            validators.validate_password(password=password, user=User)
        except exceptions.ValidationError as error:
            errors['password'] = list(error.messages)

        # raise all errors
        if errors:
            raise serializers.ValidationError(errors)

        return super(RegisterSerializer, self).validate(data)

    def create(self, validated_data):
        """
        Create user.
        """
        user = User.objects.create(username=validated_data['username'],
                                        email=validated_data['email'],
                                        password=validated_data['password'])
        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)
        if user and user.is_active:
            return user
        raise serializers.ValidationError("Hmmm... we don't seem to have those credentials. Please try again.")