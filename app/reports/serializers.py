from .models import CommentReport, ImageReport
from rest_framework import serializers
from django.contrib.auth.models import User

class ImageReportSerializer(serializers.ModelSerializer):

    class Meta:
        model = ImageReport
        fields = [
            'user',
            'type',
        ]


class CommentReportSerializer(serializers.ModelSerializer):

    class Meta:
        model = CommentReport
        fields = [
            'user',
            'type',
        ]