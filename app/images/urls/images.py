from rest_framework import routers
from ..views import ImageViewSet, CollectionViewSet, CaptionViewSet, CommentViewSet, UserViewSet


# register app APIs
router = routers.DefaultRouter()
router.register('images', ImageViewSet, 'images')
router.register('collections', CollectionViewSet, 'collections')
router.register('captions', CaptionViewSet, 'captions')
router.register('comments', CommentViewSet, 'comments')
router.register('users', UserViewSet, 'users')

# set urls for images APIs
urlpatterns = router.urls