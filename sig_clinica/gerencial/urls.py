from django.conf.urls import url, include
from .views import *

app_name = 'gerencial'

urlpatterns = [
    url(r'^prueba/', prueba, name='prueba'),
    url(r'^resumen_expcreados/', resumen_expcreados, name='expcreados'),

]