from django.urls import path, include
from .views import *

app_name = 'gerencial'

urlpatterns = [
    url(r'^prueba/', prueba, name='prueba'),
    url(r'^resumen_expcreados/', resumen_expcreados, name='expcreados'),

]