from axes.models import AccessAttempt
from axes.utils import reset
from django.conf import settings
from django.contrib import messages
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.contrib.auth import tokens
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User, Group
from django.core.mail import EmailMessage
from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect, reverse
from django.template.loader import get_template
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode

from .forms import UsuarioForm, UsuarioUpdateForm


def administrador(user):
    return user.groups.filter(name="administrador").exists()


def estrategico(user):
    return user.groups.filter(name="estrategico").exists()


def tactico(user):
    return user.groups.filter(name="tactico").exists()


# Create your views here.
def login(request):
    message = []
    next = request.GET.get('next')
    if request.POST:
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            auth_login(request, user)
            reset(username=username)
            if next:
                return redirect(next)
            else:
                return redirect('/')
        else:
            message = ["Usuario o password Incorrecto", messages.WARNING]
            try:
                axes = AccessAttempt.objects.get(username=username)
                user = User.objects.get(username=username)
                if user.is_staff or user.is_superuser:
                    # Las cuentas de administrador no se bloquearán
                    reset(username=user.username)
                else:
                    if user.is_active:
                        if axes.failures_since_start >= settings.AXES_FAILURE_LIMIT:
                            user.is_active = False
                            user.save()
                            message = ["Usuario bloqueado, póngase en contacto con el administrador", messages.ERROR]
                        else:
                            message = ["Contraseña errónea le quedan " + str(
                                settings.AXES_FAILURE_LIMIT - axes.failures_since_start) + " intentos", messages.WARNING]
                    else:
                        message = ["Usuario bloqueado, póngase en contacto con el administrador", messages.ERROR]
            except:
                pass
            messages.add_message(request, message[1], message[0])
            return render(request, 'registration/login.html', {'message': message, })
    else:
        return render(request, 'registration/login.html', {'message': message, })


def logout(request):
    auth_logout(request)
    return redirect('/auth/login/')


@login_required
def cuenta(request):
    message = ""
    user = request.user
    if request.POST:
        if request.POST.get('contraseña'):
            if request.POST.get('contraseña') == request.POST.get('contraseña2'):
                user.password = make_password(request.POST.get('contraseña'), None, 'argon2')
            else:
                message = "Las contraseñas no coinciden, vuelva a intentarlo"
                messages.error(request, message)
                context = {'nombre': user.first_name,
                           'apellido': user.last_name,
                           'email': user.email,
                           'message': message}
                return render(request, "auth/cuenta.html", context)

        if request.POST.get('nombres'):
            user.first_name = request.POST.get('nombres')
        if request.POST.get('apellidos'):
            user.last_name = request.POST.get('apellidos')
        if request.POST.get('correo'):
            user.email = request.POST.get('correo')
        try:
            user.save()
            message = "Datos modificados con éxito"
            messages.success(request, message)
        except:
            message = "Error al modificar datos"
            messages.error(request, message)
    user = User.objects.get(pk=user.id)
    print(message)
    context = {'nombre': user.first_name,
               'apellido': user.last_name,
               'email': user.email,
               'message': message}
    return render(request, "auth/cuenta.html", context)


# Inician vistas para Usuarios
@login_required
@user_passes_test(administrador)
def agregar_usuario(request):
    mensaje = ""
    if request.method == 'POST':
        form = UsuarioForm(request.POST)
        if form.is_valid():
            try:
                # user = User(**form.cleaned_data)
                username = form.cleaned_data['username']
                first_name = form.cleaned_data['first_name']
                last_name = form.cleaned_data['last_name']
                email = form.cleaned_data['email']
                group = form.cleaned_data['groups']
                group = Group.objects.get(pk=int(group))
                user = User(username=username, first_name=first_name, last_name=last_name, email=email)
                user.set_unusable_password()
                user.save()
                user.groups.add(group)
                template = get_template('auth/email_password.html')
                token = tokens.PasswordResetTokenGenerator()
                content = template.render(
                    {'user': user, 'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                     'token': token.make_token(user), 'request': request, })
                email = EmailMessage('Creación de password', content, to={user.email, })
                email.send()
                mensaje = "Usuario creado con éxito"
                messages.success(request, mensaje)
                # Limpiando campos después de guardar (Reset Forms)
                form = UsuarioForm()
            except Exception as e:
                mensaje = "Error al crear el usuario, {}".format(e)
                messages.error(request, mensaje)

    else:
        form = UsuarioForm()

    return render(request, 'auth/add_user.html', {'form': form, 'mensaje': mensaje})


@login_required
def usuarios(request):
    mensaje = ""
    if request.user.groups.filter(name="administrador").exists():
        user_list = User.objects.all().exclude(pk=request.user.id)
        return render(request, 'auth/users.html', {'user_list': user_list, 'mensaje': mensaje, })
    else:
        mensaje = "No posee permisos para acceder a la página solicitada. Para continuar inicie sesión con un usuario privilegiado"
        messages.error(request, mensaje)
        return render(request, 'auth/login.html', {'mensaje': mensaje, })


@login_required
@user_passes_test(administrador)
def actualizar_usuario(request, pk):
    mensaje = ""
    try:
        user = User.objects.get(pk=pk)
    except:
        messages.add_message(request, messages.INFO, 'El Usuario especificado no existe')
        return HttpResponseRedirect(reverse("usuarios"))

    if request.method == 'POST':
        form = UsuarioUpdateForm(request.POST)
        if form.is_valid():
            try:
                user.username = form.cleaned_data['username']
                user.first_name = form.cleaned_data['first_name']
                user.last_name = form.cleaned_data['last_name']
                user.email = form.cleaned_data['email']
                group = form.cleaned_data['groups']
                group = Group.objects.get(pk=int(group))
                user.groups.clear()
                user.groups.add(group)
                user.save()
                mensaje = "Usuario modificado con éxito"
                messages.success(request,mensaje)
            except Exception as e:
                mensaje = "Error al modificar el usuario {}".format(e)
                messages.error(request, mensaje)
    else:
        groups = user.groups.first()
        if groups:
            groups = groups.id
        else:
            groups = Group.objects.first()
        data = {
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'groups': groups,
        }
        form = UsuarioUpdateForm(initial=data)

    return render(request, 'auth/add_user.html', {'form': form, 'mensaje': mensaje, 'actualizar': True})


@login_required
@user_passes_test(administrador)
def eliminar_usuario(request, pk):
    if request.user.id != int(pk):
        try:
            usuario = User.objects.get(pk=pk)
            usuario.delete()
            messages.add_message(request, messages.INFO, 'Usuario eliminado con éxito')
        except:
            messages.add_message(request, messages.INFO, 'Error al eliminar el usuario')
    else:
        messages.add_message(request, messages.INFO, 'No puede eliminar su propio usuario')
    return HttpResponseRedirect('/auth/usuarios')


@login_required
@user_passes_test(administrador)
def bloquear_usuario(request, pk):
    if request.user.id != int(pk):
        try:
            user = User.objects.get(pk=pk)
            user.is_active = not user.is_active
            user.save()
            reset(username=user.username)
            messages.add_message(request, messages.SUCCESS, 'Cambio de estado exitoso')
        except:
            messages.add_message(request, messages.INFO, 'Error al cambiar el estado del usuario')
    else:
        messages.add_message(request, messages.INFO, 'No puede bloquear su propio usuario')
    return HttpResponseRedirect(reverse("usuarios"))
# Finalizan vistas para Usuarios

def lockout(request):
    return render(request, template_name='registration/locked.html')