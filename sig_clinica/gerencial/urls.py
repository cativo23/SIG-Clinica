from django.urls import path

from .views import obtener_resumen_expcreados, obtener_resumen_costomed, obtener_resumen_expdeudas, obtener_resumen_ingresoConsultas, index, menu

app_name = 'gerencial'

urlpatterns = [
    path('', index, name='index'),
    path('menu/', menu, name='menu'),
    path('resumen_expcreados/', obtener_resumen_expcreados, name='resumen_expcreados'),
    path('resumen_expdeudas/', obtener_resumen_expdeudas, name='resumen_expdeudas'),
    path('resumen_costomed/', obtener_resumen_costomed, name='resumen_expdeudas'),
    path('resumen_ingobtenidos/', obtener_resumen_ingresoConsultas, name='resumen_ingrObtenido')
]