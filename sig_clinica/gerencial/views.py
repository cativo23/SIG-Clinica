from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import render
from auth1.views import administrador

# Create your views here.

#
#@user_passes_test(administrador)
#def prueba(request):
 #   return render(request, template_name='base.html')