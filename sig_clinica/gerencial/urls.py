from django.urls import path

from .views import obtener_resumen_expcreados, obtener_resumen_costomed, obtener_resumen_expdeudas, \
    obtener_resumen_ingresoConsultas, index, obtener_resumen_tratmientosreq, obtener_resumen_recetamed, \
    obtener_resumen_vencimiento, obtener_resumen_nuevorecurrente


app_name = 'gerencial'

urlpatterns = [
    path('', index, name='index'),
    path('resumen_expcreados/', obtener_resumen_expcreados, name='resumen_expcreados'),
    path('resumen_expdeudas/', obtener_resumen_expdeudas, name='resumen_expdeudas'),
    path('resumen_costomed/', obtener_resumen_costomed, name='resumen_costomed'),
    path('resumen_ingobtenidos/', obtener_resumen_ingresoConsultas, name='resumen_ingrObtenido'),
    path('resumen_tratamientosrec/', obtener_resumen_tratmientosreq, name='resumen_tratamientorec'),
    path('resumen_recetamed/', obtener_resumen_recetamed, name='resumen_recetamed'),
    path('resumen_vencimiento/', obtener_resumen_vencimiento, name='resumen_vencimiento'),
    path('resumen_nuevorecurrente/', obtener_resumen_nuevorecurrente,
         name='resumen_nuevorecurrente'),
]
