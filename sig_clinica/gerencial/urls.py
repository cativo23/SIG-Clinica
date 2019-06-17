from django.urls import path, include
from .views import *

app_name = 'gerencial'

urlpatterns = [
    path('menu/', menu, name='menu'),
    path('resumen_expcreados/', obtener_resumen_expcreados, name='resumen_expcreados'),
    path('resumen_expdeudas/', obtener_resumen_expdeudas, name='resumen_expdeudas'),
    path('resumen_costomed/', obtener_resumen_costomed, name='resumen_expdeudas'),

]