from images.models import Collection, Image
from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
    bio = models.TextField("Bio", max_length=500, blank=True)
    interests = models.ManyToManyField(Collection, related_name="interests", blank=True)
    image = models.OneToOneField(Image, related_name="image", on_delete=models.SET_NULL, null=True, blank=True)
    location = models.CharField("Location", max_length=240, default="World")
    following = models.ManyToManyField(User, related_name="following", symmetrical=False, blank=True)

    def __str__(self) -> str:
        return self.user.username

    def save(self, *args, **kwargs):
        """
        Remove deleted image object and ensure user cannot 
        follow themselves.
        """
        # remove deleted image
        try:
            profile = Profile.objects.get(id=self.id)
            if profile.image != self.image:
                Image.objects.get(uuid=profile.image.uuid).delete()
        except: 
            pass
        
        # ensure user doesn't follow themselves
        try: 
            following = set(self.following.all())
            if self.user in following:
                self.following.remove(self.user)
        except:
            pass
        
        super(Profile, self).save(*args, **kwargs)

    def total_following(self):
        return self.following.count()
    
    def total_followers(self):
        return Profile.objects.filter(following=self.user).count()


@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()
