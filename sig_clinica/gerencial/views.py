from django.shortcuts import render

# Create your views here.


def prueba(request):
    return render(request, template_name='base.html')

def resumen_expcreados(request):
    return render(request, template_name='resumen_expcreados.html' )