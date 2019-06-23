from django import forms
from django.contrib.auth.models import User, Group
from material import Layout, Fieldset, Row


class UsuarioForm(forms.Form):
    username = forms.CharField(error_messages={'required': 'Campo obligatorio'}, min_length=8, max_length=30,
                               label='Nombre de Usuario', help_text='Al menos 8 caracteres.')
    first_name = forms.CharField(error_messages={'required': 'Campo obligatorio'}, label='Nombre')
    last_name = forms.CharField(error_messages={'required': 'Campo obligatorio'}, label='Apellidos')
    email = forms.EmailField(error_messages={'required': 'Campo obligatorio'}, label='Dirección de Correo Electrónico')

    groups = forms.ChoiceField(choices=[(x.id, x.name) for x in Group.objects.all()], label='Perfil de Acceso')

    layout = Layout(Fieldset('Agregar Usuario: '), Row('username', 'email'), Row('first_name', 'last_name'),
                    Row('groups'))

    def clean_email(self):
        email = self.cleaned_data['email'].lower()
        username = self.cleaned_data.get('username')
        if email and User.objects.filter(email=email).exclude(username=username).exists():
            raise forms.ValidationError("¡Ya existe un usuario con ese email!")
        return email


class UsuarioUpdateForm(forms.Form):
    username = forms.CharField(error_messages={'required': 'Campo obligatorio'}, min_length=8, max_length=30, label='Nombre de Usuario', widget=forms.TextInput(attrs={'readonly':'readonly'}))
    first_name = forms.CharField(error_messages={'required': 'Campo obligatorio'}, label='Nombre')
    last_name = forms.CharField(error_messages={'required': 'Campo obligatorio'}, label='Apellidos')
    email = forms.EmailField(error_messages={'required': 'Campo obligatorio'}, label='Dirección de Correo Electrónico')

    # Para solucionar error en las migraciones iniciales
    try:
        groups = forms.ChoiceField(choices=[(x.id, x.name) for x in Group.objects.all()], label='Perfil de Acceso', help_text='Por favor seleccione el Perfil de Acceso que tendrá este Usuario')
    except:
        pass
    layout = Layout(Fieldset('Agregar Usuario: '), Row('username', 'email'), Row('first_name', 'last_name'), Row('groups'))

    def clean_email(self):
        email = self.cleaned_data['email'].lower()
        username = self.cleaned_data.get('username')
        if email and User.objects.filter(email=email).exclude(username=username).exists():
            raise forms.ValidationError("¡Ya existe un usuario con ese email!")
        return email
