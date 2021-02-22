from django.test import SimpleTestCase
from django.urls import reverse, resolve
from images.views import images_list, image_details
from django.contrib import admin


class TestUrls(SimpleTestCase):
    def test_images_list_url_resolves(self):
        """
        Images list API resolves correctly.
        """
        url = reverse('images_list')
        self.assertEquals(resolve(url).func, images_list)

    def test_image_details_url_resolves(self):
        """
        Image details API resolves correctly.
        """
        url = reverse('image_details')
        self.assertEquals(resolve(url).func, image_details)