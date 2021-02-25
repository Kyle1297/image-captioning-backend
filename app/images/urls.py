from rest_framework import routers
from .views import *


# register app APIs
router = routers.DefaultRouter()
router.register('images', ImageViewSet, 'images')
router.register('collections', CollectionViewSet, 'collections')
router.register('captions', CaptionViewSet, 'captions')

# set urls for APIs
urlpatterns = router.urls