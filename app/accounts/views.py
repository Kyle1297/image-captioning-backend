from django.contrib.auth.models import User
from django.http.request import HttpRequest
from rest_framework import serializers, viewsets
from django.http.response import HttpResponse
from .serializers.user import PublicUserSerializer, UserSerializer
from .serializers.login import LoginSerializer, RegisterSerializer
from rest_framework import generics, permissions, response
from knox.models import AuthToken


class RegisterAPIView(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        return response.Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(user)[1],
        })


class LoginAPIView(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request: HttpRequest, *args, **kwargs) -> HttpResponse:
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data
        return response.Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(user)[1],
        })


class UserAPIView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [
        permissions.IsAuthenticated,    
    ]
    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user


class PublicUserAPIView(generics.RetrieveAPIView):
    permission_classes = [
        permissions.IsAuthenticatedOrReadOnly,
    ]
    serializer_class = PublicUserSerializer
    queryset = User.objects.all()

    def get_object(self):
        try:
            user = User.objects.get(username=self.kwargs['username'])
            return user
        except Exception:
            raise serializers.ValidationError("Invalid username received.")