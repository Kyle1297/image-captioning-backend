# Generated by Django 3.1.6 on 2021-04-09 19:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('images', '0012_auto_20210409_1530'),
    ]

    operations = [
        migrations.AlterField(
            model_name='image',
            name='uuid',
            field=models.UUIDField(editable=False, primary_key=True, serialize=False, unique=True, verbose_name='UUID'),
        ),
    ]
