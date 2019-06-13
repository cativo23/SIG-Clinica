from django.urls import path

from .views import *

app_name = 'gerencial'

urlpatterns = [
    path('', index, name='index'),
]