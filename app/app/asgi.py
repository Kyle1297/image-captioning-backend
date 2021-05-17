import os
import django
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from images.routing import websocket_urlpatterns
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')
django.setup()

application = ProtocolTypeRouter({
  "http": get_asgi_application(),
 	'websocket': AuthMiddlewareStack(
		URLRouter(
    		websocket_urlpatterns
    	)
  	)
})