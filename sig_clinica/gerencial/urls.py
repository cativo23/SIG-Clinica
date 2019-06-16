from django.urls import path, include
from .views import *

app_name = 'gerencial'

urlpatterns = [
    path('resumen_expcreados/', obtener_resumen_expcreados, name='resumen_expcreados'),
    path('resumen_expdeudas/', obtener_resumen_expdeudas, name='resumen_expdeudas'),
]