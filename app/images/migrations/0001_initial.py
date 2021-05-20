# Generated by Django 3.1.6 on 2021-05-20 09:01

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import uuid


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Collection',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('category', models.CharField(db_index=True, max_length=100, unique=True, verbose_name='Category')),
                ('is_main', models.BooleanField(default=False, verbose_name='Main category')),
                ('creator', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='creators', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['category'],
            },
        ),
        migrations.CreateModel(
            name='Image',
            fields=[
                ('uuid', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False, unique=True, verbose_name='UUID')),
                ('s3_key', models.CharField(max_length=240, verbose_name='Key')),
                ('type', models.CharField(max_length=100, verbose_name='Type')),
                ('width', models.PositiveIntegerField(default=0, verbose_name='Width')),
                ('height', models.PositiveIntegerField(default=0, verbose_name='Height')),
                ('title', models.CharField(db_index=True, max_length=240, verbose_name='Title')),
                ('uploaded_at', models.DateTimeField(auto_now_add=True)),
                ('is_profile_image', models.BooleanField(default=False, verbose_name='Profile image')),
                ('is_private', models.BooleanField(default=False, verbose_name='Private image')),
                ('views', models.PositiveIntegerField(default=0, verbose_name='Views')),
                ('downloads', models.PositiveIntegerField(default=0, verbose_name='Downloads')),
                ('collections', models.ManyToManyField(blank=True, related_name='images', to='images.Collection')),
                ('dislikes', models.ManyToManyField(blank=True, related_name='image_dislikes', to=settings.AUTH_USER_MODEL)),
                ('likes', models.ManyToManyField(blank=True, related_name='image_likes', to=settings.AUTH_USER_MODEL)),
                ('uploader', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='uploaders', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['-uploaded_at'],
            },
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('comment', models.TextField(blank=True, max_length=500)),
                ('commented_at', models.DateTimeField(editable=False)),
                ('last_edited', models.DateTimeField(null=True)),
                ('commenter', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='commenters', to=settings.AUTH_USER_MODEL)),
                ('dislikes', models.ManyToManyField(blank=True, related_name='comment_dislikes', to=settings.AUTH_USER_MODEL)),
                ('image', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comments', to='images.image')),
                ('likes', models.ManyToManyField(blank=True, related_name='comment_likes', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['-commented_at'],
            },
        ),
        migrations.CreateModel(
            name='Caption',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('text', models.CharField(db_index=True, max_length=500, verbose_name='Caption')),
                ('satisfactory', models.BooleanField(null=True, verbose_name='Satisfactory')),
                ('corrected_text', models.CharField(blank=True, db_index=True, max_length=240, verbose_name='Corrected Caption')),
                ('last_updated', models.DateTimeField(null=True)),
                ('image', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='caption', to='images.image')),
            ],
        ),
    ]
