from rest_framework import routers
from ..views import ImageViewSet, CollectionViewSet, CaptionViewSet


# register app APIs
router = routers.DefaultRouter()
router.register('images', ImageViewSet, 'images')
router.register('collections', CollectionViewSet, 'collections')
router.register('captions', CaptionViewSet, 'captions')

# set urls for images APIs
urlpatterns = router.urls