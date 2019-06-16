from django.urls import path, include
from django.contrib.auth.views import PasswordResetView, PasswordResetDoneView, PasswordResetConfirmView, PasswordResetCompleteView, LoginView
from .views import *


urlpatterns = [
    path('login/', LoginView.as_view(template_name='auth/login.html'), name='login'),
    path('logout/', logout, name='logout'),
    path('cuenta/', cuenta, name='cuenta'),

    # Inician urls para Usuario
    path('agregar_usuario/', agregar_usuario, name='agregar_usuario'),
    path('usuarios/', usuarios, name='usuarios'),
    path('actualizar_usuario/', actualizar_usuario, name='actualizar_usuario'),
    path('eliminar_usuario/<int:pk>/', eliminar_usuario, name='eliminar_usuario'),
    path('bloquear_usuario/<int:pk>/', bloquear_usuario, name='bloquear_usuario'),
    # Finalizan urls para Usuario

    path('password_reset/', PasswordResetView.as_view(template_name='auth/password_reset1.html'), name='password_reset'),
    path('password_reset/done/', PasswordResetDoneView.as_view(template_name='auth/password_reset_done.html'), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', PasswordResetConfirmView.as_view(template_name='auth/password_reset_confirm.html'), name='password_reset_confirm'),
    path('reset/done/', PasswordResetCompleteView.as_view(template_name='auth/password_reset_complete.html'), name='password_reset_complete'),
]
