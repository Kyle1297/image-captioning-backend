# Generated by Django 3.1.6 on 2021-02-21 20:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('images', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='image',
            name='image',
            field=models.ImageField(upload_to='', verbose_name='Image'),
        ),
    ]