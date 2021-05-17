# Generated by Django 3.1.6 on 2021-04-09 15:30

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('images', '0011_auto_20210409_1417'),
    ]

    operations = [
        migrations.AlterField(
            model_name='image',
            name='uploader',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='image_uploaders', to=settings.AUTH_USER_MODEL),
        ),
    ]
