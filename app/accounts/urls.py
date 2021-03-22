from django.urls import path, include
from .views import LoginAPIView, RegisterAPIView, UserAPIView
from knox import views as knox_views


# set urls for accounts APIs
urlpatterns = [
    path('', include('knox.urls')),
    path('register', RegisterAPIView.as_view(), name="register"),
    path('login', LoginAPIView.as_view(), name="login"),
    path('user', UserAPIView.as_view(), name="user"),
    path('logout', knox_views.LogoutView.as_view(), name="logout")
]