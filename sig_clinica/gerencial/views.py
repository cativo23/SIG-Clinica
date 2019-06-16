from django.contrib.auth.decorators import user_passes_test, login_required
from django.shortcuts import render


# Create your views here.
# @user_passes_test(administrador)
@login_required()
def index(request):
    return render(request, template_name='index.html')


