from datetime import datetime, timedelta
from django.contrib.auth.decorators import user_passes_test, login_required
from django.db.models import Sum
from django.shortcuts import render
from authentication.views import administrador
from .models import Expediente, Paciente, Consulta, Medicamento, Procedimiento, LoteMedicamento

from django.http import HttpResponse
from django.core import serializers
from django.contrib.auth.models import User

from datetime import timedelta
from datetime import date
from datetime import datetime

import datetime
import time
import math
import collections


# Create your views here.
# @user_passes_test(administrador)
@login_required()
def index(request):
    fecha1=datetime.datetime.now()
    fecha2=datetime.datetime.now()
    total=[]

    meds = Medicamento.objects.all()
    meds1 = []
    lotes = LoteMedicamento.objects.filter(fecha_vencimiento__range=[fecha1, fecha2])
    for lote in lotes:
        meds1.append(meds.filter(lotemedicamento=lote))

    hola = collections.Counter(meds1)
    print(hola)
    print(meds1)


    for lote in lotes:
        total.append(lote.cantidad * lote.medicamento.precio_producto)
    print(total)


    return render(request, template_name='index.html')


def menu(request):
    return render(request, template_name='base.html')


# Funcion que obtiene el RESUMEN DE EXPEDIENTES CREADOS para un periodo
def obtener_resumen_expcreados(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    sexo_exp_mas = ""
    sexo_exp_fem = ""
    sexo_con_mas = ""
    sexo_con_fem = ""

    edad_exp_me = ""
    edad_exp_ma = ""
    edad_con_me = ""
    edad_con_ma = ""

    exp_total = ""
    con_total = ""

    if request.method == 'POST':

        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')

        if fecha_inicial and fecha_final:

            # TABLA 1 POR SEXO
            sexo_exp_mas = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).filter(
                paciente__sexo='M').count()
            sexo_exp_fem = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).filter(
                paciente__sexo='F').count()

            sexo_con_mas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__sexo='M').count()
            sexo_con_fem = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__sexo='F').count()

            # TABLA 2 POR EDAD

            pacientes_exp = Paciente.objects.filter(expediente__fechaCreacion__range=[fecha_inicial, fecha_final])

            menores_exp = []
            mayores_exp = []

            # Recorriendo pacientes para saber su edad de expetientes nuevos
            for paciente_exp in pacientes_exp:
                edad = hoy.year - paciente_exp.fechaNacimiento.year - ((hoy.month, hoy.day) < (
                    paciente_exp.fechaNacimiento.month, paciente_exp.fechaNacimiento.day))

                if edad < 18:
                    menores_exp.append(paciente_exp)
                else:
                    mayores_exp.append(paciente_exp)

            edad_exp_me = len(menores_exp)
            edad_exp_ma = len(mayores_exp)

            pacientes_con = Paciente.objects.filter(
                expediente__consulta__fechaConsulta__range=[fecha_inicial, fecha_final])

            menores_con = []
            mayores_con = []

            # Recorriendo pacientes para saber su edad de consultas nuevas
            for paciente_con in pacientes_con:
                edad = hoy.year - paciente_con.fechaNacimiento.year - ((hoy.month, hoy.day) < (
                    paciente_con.fechaNacimiento.month, paciente_con.fechaNacimiento.day))
                if edad < 18:
                    menores_con.append(paciente_con)
                else:
                    mayores_con.append(paciente_con)

            edad_con_me = len(menores_con)
            edad_con_ma = len(mayores_con)

            # TABLA 3 TOTALES
            exp_total = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).count()
            con_total = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).count()

    return render(request, template_name='resumen_expcreados.html',
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                           'sexo_exp_mas': sexo_exp_mas, 'sexo_exp_fem': sexo_exp_fem,
                           'sexo_con_mas': sexo_con_mas, 'sexo_con_fem': sexo_con_fem,
                           'edad_exp_me': edad_exp_me, 'edad_exp_ma': edad_exp_ma,
                           'edad_con_me': edad_con_me, 'edad_con_ma': edad_con_ma,
                           'exp_total': exp_total, 'con_total': con_total})


# Funcion que obtiene el RESUMEN DE EXPEDIENTES CON DEUDAS para un periodo
def obtener_resumen_expdeudas(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    exp_deuda = ""
    exp_deuda_total = ""

    dueda_mayor20 = ""
    total_deuda20 = ""
    porce_deuda20 = ""

    exp_mayor_deuda = ""
    total_mayor_deuda = ""

    if request.method == 'POST':
        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')

        if fecha_inicial and fecha_final:

            # TABLA 1: EXPEDIENTES CON DEUDAS Y MONTO TOTAL DE ESOS EXPEDIENTES
            exp_deuda = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).filter(
                saldo__gt=0).count()

            expedientes_con_deuda = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).filter(
                saldo__gt=0)
            exp_deuda_total = 0
            for expediente_deu in expedientes_con_deuda:
                exp_deuda_total = exp_deuda_total + expediente_deu.saldo

            # TABLA 2: PACIENTES CON CON DEUDAS MAYORES A 20, TOTAL Y PORCENTAJE
            dueda_mayor20 = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).filter(
                saldo__gte=20).count()

            expedientes_deuda_mayor20 = Expediente.objects.filter(
                fechaCreacion__range=[fecha_inicial, fecha_final]).filter(saldo__gte=20)

            total_deuda20 = 0
            for expediente_mayo20 in expedientes_deuda_mayor20:
                total_deuda20 = total_deuda20 + expediente_mayo20.saldo

            # Vereficando que exp_deuda sea diferente de cero
            if exp_deuda != 0:
                porce_deuda20 = "{:.2f}".format(dueda_mayor20 / exp_deuda * 100)
            else:
                porce_deuda20 = 0

            # TABLA 3: EXPEDIENTE CON MAYOR DEUDA Y MONTO DE LA DEUDA
            exps_mayor_deuda = Expediente.objects.filter(fechaCreacion__range=[fecha_inicial, fecha_final]).order_by(
                "-saldo")

            # Verificando si existe expedientes con deudas
            lista_exps_mayor = []
            for exps_mayor in exps_mayor_deuda:
                lista_exps_mayor.append(exps_mayor)

            n_lista = len(lista_exps_mayor)

            if n_lista != 0:
                exp_mayor_deuda = exps_mayor_deuda[0].paciente
                total_mayor_deuda = exps_mayor_deuda[0].saldo
            else:
                exp_mayor_deuda = "No hay expedientes con deudas"
                total_mayor_deuda = 0

    return render(request, template_name='resumen_expdeudas.html',
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                           'exp_deuda': exp_deuda, 'exp_deuda_total': exp_deuda_total,
                           'dueda_mayor20': dueda_mayor20, 'total_deuda20': total_deuda20,
                           'porce_deuda20': porce_deuda20,
                           'exp_mayor_deuda': exp_mayor_deuda, 'total_mayor_deuda': total_mayor_deuda,
                           })


def obtener_resumen_costomed(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    med_demandados = ""
    medicamentos = ""
    total_gasto_med = ""
    mas_demandados = ""
    lista_medicamentos = ""
    a = ""

    if request.method == 'POST':
        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')

        # TABLA 1 MEDICAMENTOS MAS DEMANDADOS

        med_demandados = Medicamento.objects.filter(
            receta__consulta__fechaConsulta__range=[fecha_inicial, fecha_final]).all()

        lista_medicamentos = []
        for med in med_demandados:
            lista_medicamentos.append(med.nombre_producto)

        mas_demandados = collections.Counter(lista_medicamentos)
        b = mas_demandados.items()

        a = Medicamento.objects.filter(nombre_producto=b[0][0])

        med_demandados = Medicamento.objects.filter(
            receta__consulta__fechaConsulta__range=[fecha_inicial, fecha_final]).order_by("-precio_producto")

        # TABLA 2

        # TABLA 3 TOTAL GASTADO EN MEDICAMENTO

    return render(request, template_name="resumen_costomed.html",
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                           'med_demandados': med_demandados, 'lista_medicamentos': lista_medicamentos,
                           'mas_demandados': mas_demandados,
                           'a': a
                           })


def obtener_resumen_ingresoConsultas(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    sexo_con_mas_num = ""
    sexo_con_fem_num = ""

    total_consulta_mas = 0
    total_consulta_fem = 0

    edad_con_me = ""
    edad_con_ma = ""

    total_consulta_men = 0
    total_consulta_may = 0

    con_total = 0
    ingresos = 0

    if request.method == 'POST':

        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')

        if fecha_inicial and fecha_final:

            # TABLA POR SEXO
            sexo_con_mas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__sexo='M').all()
            sexo_con_fem = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__sexo='F').all()

            sexo_con_mas_num = sexo_con_mas.count()
            sexo_con_fem_num = sexo_con_fem.count()

            for consulta in sexo_con_mas:
                total_consulta_mas += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_mas += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            for consulta in sexo_con_fem:
                total_consulta_fem += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_fem += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            # TABLA POR EDAD

            consultas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final])

            menores_con = []
            mayores_con = []

            # Recorriendo pacientes para saber su edad de consultas nuevas
            for consulta in consultas:
                edad = hoy.year - consulta.paciente.paciente.fechaNacimiento.year - ((hoy.month, hoy.day) < (
                    consulta.paciente.paciente.fechaNacimiento.month, consulta.paciente.paciente.fechaNacimiento.day))
                if edad < 18:
                    menores_con.append(consulta)
                else:
                    mayores_con.append(consulta)

            edad_con_me = len(menores_con)
            edad_con_ma = len(mayores_con)

            for consulta in menores_con:
                total_consulta_men += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_men += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            for consulta in mayores_con:
                total_consulta_may += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_may += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            # TABLA 3 TOTALES
            con_total = consultas.count()
            for consulta in consultas:
                ingresos += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta)
                ingresos += procedimientos.aggregate(Sum("tratamiento__precioBase"))["tratamiento__precioBase__sum"]

        return render(request, template_name='resumenes/resumen_ingobtenidos.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'sexo_con_mas': sexo_con_mas_num, 'sexo_con_fem': sexo_con_fem_num,
                               'total_consulta_mas': total_consulta_mas, 'total_consulta_fem': total_consulta_fem,
                               'edad_con_me': edad_con_me, 'edad_con_ma': edad_con_ma, 'con_total': con_total,
                               'ingresos': ingresos,
                               'total_consulta_men': total_consulta_men, "total_consulta_may": total_consulta_may})
    else:
        return render(request, template_name='resumenes/resumen_ingobtenidos.html')


def obtener_resumen_tratamientoRecu(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    sexo_con_mas_num = ""
    sexo_con_fem_num = ""

    total_consulta_mas = 0
    total_consulta_fem = 0

    edad_con_me = ""
    edad_con_ma = ""

    total_consulta_men = 0
    total_consulta_may = 0

    con_total = 0
    ingresos = 0

    if request.method == 'POST':

        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')

        if fecha_inicial and fecha_final:

            # TABLA POR SEXO
            sexo_con_mas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__sexo='M').all()
            sexo_con_fem = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__sexo='F').all()

            sexo_con_mas_num = sexo_con_mas.count()
            sexo_con_fem_num = sexo_con_fem.count()

            for consulta in sexo_con_mas:
                total_consulta_mas += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_mas += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            for consulta in sexo_con_fem:
                total_consulta_fem += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_fem += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            # TABLA POR EDAD

            consultas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final])

            menores_con = []
            mayores_con = []

            # Recorriendo pacientes para saber su edad de consultas nuevas
            for consulta in consultas:
                edad = hoy.year - consulta.paciente.paciente.fechaNacimiento.year - ((hoy.month, hoy.day) < (
                    consulta.paciente.paciente.fechaNacimiento.month, consulta.paciente.paciente.fechaNacimiento.day))
                if edad < 18:
                    menores_con.append(consulta)
                else:
                    mayores_con.append(consulta)

            edad_con_me = len(menores_con)
            edad_con_ma = len(mayores_con)

            for consulta in menores_con:
                total_consulta_men += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_men += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            for consulta in mayores_con:
                total_consulta_may += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta).all()
                total_consulta_may += procedimientos.aggregate(Sum("tratamiento__precioBase"))[
                    "tratamiento__precioBase__sum"]

            # TABLA 3 TOTALES
            con_total = consultas.count()
            for consulta in consultas:
                ingresos += consulta.precio
                procedimientos = Procedimiento.objects.filter(consulta_realizada=consulta)
                ingresos += procedimientos.aggregate(Sum("tratamiento__precioBase"))["tratamiento__precioBase__sum"]

        return render(request, template_name='resumenes/resumen_tratamientosreq.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'sexo_con_mas': sexo_con_mas_num, 'sexo_con_fem': sexo_con_fem_num,
                               'total_consulta_mas': total_consulta_mas, 'total_consulta_fem': total_consulta_fem,
                               'edad_con_me': edad_con_me, 'edad_con_ma': edad_con_ma, 'con_total': con_total,
                               'ingresos': ingresos,
                               'total_consulta_men': total_consulta_men, "total_consulta_may": total_consulta_may})
    else:
        return render(request, template_name='resumenes/resumen_tratamientosreq.html')
