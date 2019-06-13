from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import render


# Create your views here.
# @user_passes_test(administrador)
def index(request):
    return render(request, template_name='base.html')
