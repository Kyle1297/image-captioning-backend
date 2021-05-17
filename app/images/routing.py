from django.urls import re_path
from .consumers import CaptionSNSConsumer

websocket_urlpatterns = [
	re_path(r'ws/images/(?P<uuid>[a-z0-9-]+)/$', CaptionSNSConsumer.as_asgi()),
]