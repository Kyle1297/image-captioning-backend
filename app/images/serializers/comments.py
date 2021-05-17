from django.contrib.auth.models import User
from rest_framework import serializers
from ..models import Comment
from accounts.serializers import LimitedUserSerializer
from reports.serializers import CommentReportSerializer
from reports.models import CommentReport

class CommentSerializer(serializers.ModelSerializer):
    commenter = LimitedUserSerializer()
    report = CommentReportSerializer(required=False, write_only=True)

    class Meta:
        model = Comment
        fields = '__all__'
        extra_kwargs = {
            'last_edited': {
                'read_only': True,
            },
            'commented_at': {
                'read_only': True,
            },
        }

    def create(self, validated_data):
        commenter_id = validated_data.pop('commenter')['id']
        commenter = User.objects.get(id=commenter_id)
        return Comment.objects.create(commenter=commenter, **validated_data)

    def update(self, instance: Comment, validated_data): 
        # create new report, if desired
        if validated_data.get('report'):
            report = validated_data.pop('report')
            CommentReport.objects.create(comment=instance, **report)

        # then, update accordingly
        return super().update(instance, validated_data)  