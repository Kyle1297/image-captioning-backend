from images.utils.s3 import create_presigned_get
from django.conf import settings
from images.models import Image, Collection
from rest_framework import serializers
from django.contrib.auth.models import User
from ..models import Profile
from images.serializers import CollectionSerializer

class BaseProfileSerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Profile
        fields = [
            'image',
        ]

    def get_image(self, obj: Profile):
        if obj.image:
            filename = obj.image.title + '.' + obj.image.type
            return {
                "uuid": obj.image.uuid,
                "image": create_presigned_get(settings.AWS_MEDIA_BUCKET_NAME, obj.image.s3_key, filename)
            }


class LimitedUserSerializer(serializers.ModelSerializer):
    profile = BaseProfileSerializer(read_only=True)
    counts = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields = [
            'id',
            'profile',
            'username',
            'counts',
        ]
        extra_kwargs = {
            'id': {
                'read_only': False,
            }
        }
        read_only_fields = [
            "username",
        ]

    def get_counts(self, obj: User):
        """
        Fetch count of public images.
        """
        uploader = obj.id
        public_count = Image.objects.filter(uploader=uploader, is_private=False, is_profile_image=False).count()
        
        return {
            "public": public_count,
        }


class ProfileSerializer(BaseProfileSerializer):
    interests = CollectionSerializer(many=True)
    following = LimitedUserSerializer(many=True)
    followers = serializers.SerializerMethodField()

    class Meta(BaseProfileSerializer.Meta):
        fields = BaseProfileSerializer.Meta.fields + [
            'id',
            'bio',
            'interests',
            'location',
            'followers',
            'following',
        ]

    def get_followers(self, obj):
        queryset = User.objects.filter(profile__following=obj.user)
        serializer = LimitedUserSerializer(queryset, many=True)
        return serializer.data

class BaseUserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer()
    interest_ids = serializers.ListField(required=False, write_only=True, child=serializers.IntegerField(min_value=0), allow_empty=True)
    following_ids = serializers.ListField(required=False, write_only=True, child=serializers.IntegerField(min_value=0), allow_empty=True)
    counts = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'profile',
            'date_joined',
            'interest_ids',
            'following_ids',
            'counts',
        ]

    def get_counts(self, obj: User):
        """
        Fetch the counts of liked and private images.
        """
        uploader = obj.id
        public_count = Image.objects.filter(uploader=uploader, is_private=False, is_profile_image=False).count()
        private_count = Image.objects.filter(uploader=uploader, is_private=True, is_profile_image=False).count()
        liked_count = Image.objects.filter(uploader=uploader, likes__id=uploader).count()
        
        return {
            "public": public_count,
            "private": private_count,
            "liked": liked_count,
        }

    def validate_interest_ids(self, interest_ids):
        """
        Ensure no more than 5 interests can be chosen.
        """
        if len(interest_ids) > 5:
            raise serializers.ValidationError(["No more than 5 interests can be chosen."])
        return interest_ids


class UserSerializer(BaseUserSerializer):

    class Meta(BaseUserSerializer.Meta):
        fields = BaseUserSerializer.Meta.fields + [
            'email',
            'last_login',
            'first_name',
            'last_name',
        ]

    def update(self, instance: User, validated_data): 
        # retrieve key parameters
        following_ids = validated_data.pop('following_ids', None)
        interest_ids = validated_data.pop('interest_ids', None)
        profile = validated_data.pop('profile', None)

        # update profile, if desired
        if isinstance(following_ids, list) or isinstance(interest_ids, list) or profile:
            current_profile = instance.profile
            
            # following
            if isinstance(following_ids, list):
                following = User.objects.filter(id__in=following_ids)
                current_profile.following.set(following)

            # interests
            if isinstance(interest_ids, list):
                interests = Collection.objects.filter(id__in=interest_ids)
                current_profile.interests.set(interests)

            # rest
            if profile:
                for key in profile:
                    setattr(current_profile, key, profile[key])
            instance.profile = current_profile

        return super().update(instance, validated_data)  

    def validate_email(self, email):
        """
        Validate email on registration.
        """
        
        # check for missing email
        if not email:
            raise serializers.ValidationError(["This field may not be blank."])
        return email
        
class PublicUserSerializer(BaseUserSerializer):

    # set all fields to read only
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setattr(self.Meta, 'read_only_fields', [*self.fields])
