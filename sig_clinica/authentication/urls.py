from django.contrib.auth.views import PasswordResetView, PasswordResetDoneView, PasswordResetCompleteView, \
    PasswordResetConfirmView
from django.urls import path, include
from .views import *

urlpatterns = [
    path('login/', login, name='login'),
    path('logout/', logout, name='logout'),
    path('cuenta/', cuenta, name='cuenta'),

    # Inician urls para Usuario
    path('agregar_usuario/', agregar_usuario, name='agregar_usuario'),
    path('usuarios/', usuarios, name='usuarios'),
    path('actualizar_usuario/', actualizar_usuario, name='actualizar_usuario'),
    path('eliminar_usuario/<int:pk>/', eliminar_usuario, name='eliminar_usuario'),
    path('bloquear_usuario/<int:pk>/', bloquear_usuario, name='bloquear_usuario'),
    # Finalizan urls para Usuario

    path('password_reset/', PasswordResetView.as_view(), name='password_reset'),
    path('password_reset/done/', PasswordResetDoneView.as_view(), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('reset/done/', PasswordResetCompleteView.as_view(), name='password_reset_complete'),
    path('lockout/', lockout, name='lockout'),
]
