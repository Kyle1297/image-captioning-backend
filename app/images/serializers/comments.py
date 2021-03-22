from rest_framework import serializers
from ..models import Comment
from .users import LimitedUserSerializer


class CommentSerializer(serializers.ModelSerializer):

    class Meta:
        model = Comment
        fields = '__all__'


class LimitedCommentSerializer(serializers.ModelSerializer):
    commenter = LimitedUserSerializer(read_only=True)
    likes = LimitedUserSerializer(many=True)
    dislikes = LimitedUserSerializer(many=True)

    class Meta:
        model = Comment
        fields = [
            'id',
            'comment',
            'commenter',
            'likes',
            'dislikes',
            'commented_at',
        ]