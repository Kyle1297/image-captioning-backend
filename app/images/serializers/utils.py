from rest_framework import serializers

# method choices
GET = 'GET'
POST = 'POST'

METHOD_CHOICES = [
  	GET,
  	POST,
]

# presigned s3 url serialoizer
class SignS3Serializer(serializers.Serializer):
    method = serializers.ChoiceField(default=GET, choices=METHOD_CHOICES)
    uuid = serializers.CharField()
    file_type = serializers.CharField()
    is_private = serializers.BooleanField()
    is_profile_image = serializers.BooleanField()