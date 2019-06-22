import collections
from datetime import datetime, date
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, Count, F, FloatField, ExpressionWrapper, Q
from django.shortcuts import render

from .models import Expediente, Paciente, Consulta, Medicamento, LoteMedicamento, Tratamiento
from .models import Procedimiento, Pago


# from auth1.views import administrador

def fecha_18():
    current = datetime.now().date()
    return date(current.year - 18, current.month, current.day)


# Create your views here.
# @user_passes_test(administrador)
@login_required()
def index(request):
    return render(request, template_name='index.html')


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
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')
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

    return render(request, template_name='resumenes/resumen_expcreados.html',
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
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')
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

    return render(request, template_name='resumenes/resumen_expdeudas.html',
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                           'exp_deuda': exp_deuda, 'exp_deuda_total': exp_deuda_total,
                           'dueda_mayor20': dueda_mayor20, 'total_deuda20': total_deuda20,
                           'porce_deuda20': porce_deuda20,
                           'exp_mayor_deuda': exp_mayor_deuda, 'total_mayor_deuda': total_mayor_deuda,
                           })


class CincoMasUsados:
    def __init__(self, n, nombre, marca, monto, cantidadLotes, cantidadStock):
        self.n = n
        self.nombre = nombre
        self.marca = marca
        self.monto = monto
        self.cantidadLotes = cantidadLotes
        self.cantidadStock = cantidadStock


def obtener_resumen_costomed(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    resumen = ""
    total_gasto_med = ""

    prueba = ""

    if request.method == 'POST':
        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')
        if fecha_inicial and fecha_final:

            # TABLA 1 MEDICAMENTOS MAS DEMANDADOS

            med_deman_periodo = Medicamento.objects.filter(
                receta__consulta__fechaConsulta__range=[fecha_inicial, fecha_final])
            # print(med_deman_periodo)

            lista_medicamentos = []
            for med in med_deman_periodo:
                lista_medicamentos.append(med.nombre_producto)
            # print(lista_medicamentos)

            # Diccionario con frecuencia de aparicion de "lista_medicamentos", 'medicamento': frecuencia_de _uso
            dicc_mas_usados = collections.Counter(lista_medicamentos)  # Objeto counter
            prueba = collections.Counter(lista_medicamentos)

            print("dicc_mas_usados:", dicc_mas_usados)
            print("prueba: ", prueba)

            # Lista de los producto sin repetir
            lista = list(dicc_mas_usados)
            print("lista:", lista)

            # Obtiene una lista de 5 elemento ordenada de mayor a menos frecuencia de uso en recetas
            lista_mas_usados = []
            for ejecutar in range(4):
                i = 0
                for l in lista:
                    frecuencia_max = max(dicc_mas_usados.values())
                    frecuencia = dicc_mas_usados.get(l)
                    # print(dicc_mas_usados)
                    # print(l,"Indice:", i, "Frecuencia:",frecuencia)
                    # print ("Maxima frecuencia:",frecuencia_max)

                    if frecuencia_max == frecuencia:
                        dicc_mas_usados.pop(l)
                        lista_mas_usados.append(l)
                        lista.pop(i)
                        # print(lista_mas_usados)
                        # print(" ")
                    i = i + 1

            # print("lista_mas_usados: ", lista_mas_usados)
            # Comprobando que existen al menos 5 mediamentos mas tuilizados en recetas
            mas_usados_med = []
            if len(lista_mas_usados) >= 5:
                i = 0
                for med in range(5):
                    mas_usados_med.append(Medicamento.objects.get(nombre_producto=lista_mas_usados[i]))
                    i = i + 1
                # print(mas_usados_med)
            else:
                i = 0
                for med in range(len(lista_mas_usados)):
                    mas_usados_med.append(Medicamento.objects.get(nombre_producto=lista_mas_usados[i]))
                    i = i + 1
                # print(mas_usados_med)

            # Totales de lotes
            mas_usados_tot = []
            # Comprobando que existen al menos 5 mediamentos mas tuilizados en recetas
            if len(lista_mas_usados) >= 5:
                i = 0
                for totales in range(5):
                    total = LoteMedicamento.objects.filter(medicamento__nombre_producto=lista_mas_usados[i]).aggregate(
                        Sum('cantidad'))
                    mas_usados_tot.append(total.get('cantidad__sum'))
                    i = i + 1
                # print(mas_usados_tot)
            else:
                i = 0
                for totales in range(len(lista_mas_usados)):
                    total = LoteMedicamento.objects.filter(medicamento__nombre_producto=lista_mas_usados[i]).aggregate(
                        Sum('cantidad'))
                    mas_usados_tot.append(total.get('cantidad__sum'))
                    i = i + 1
                # print(mas_usados_tot)

            # Aqui se llena los objetos que se enviaran al html, se envia "resumen"
            resumen = []
            # Comprobando que existen al menos 5 mediamentos mas tuilizados en recetas

            if len(lista_mas_usados) >= 5:
                i = 0
                for repetir in range(5):
                    objeto = CincoMasUsados(prueba.get(mas_usados_med[i].nombre_producto),
                                            mas_usados_med[i].nombre_producto, mas_usados_med[i].marca_producto,
                                            mas_usados_med[i].precio_producto, mas_usados_tot[i],
                                            mas_usados_med[i].existencia_producto)
                    resumen.append(objeto)
                    i = i + 1
            else:
                i = 0
                for repetir in range(len(lista_mas_usados)):
                    objeto = CincoMasUsados(prueba.get(mas_usados_med[i].nombre_producto),
                                            mas_usados_med[i].nombre_producto, mas_usados_med[i].marca_producto,
                                            mas_usados_med[i].precio_producto, mas_usados_tot[i],
                                            mas_usados_med[i].existencia_producto)
                    resumen.append(objeto)
                    i = i + 1

            # TABLA 2 TOTAL GASTADO EN MEDICAMENTO

            total_gasto_med = 0
            # lista contiene los medicamentos usados en el periodo sin repetir medicamentos
            lista2 = lista_mas_usados
            i = 0
            for l in lista2:
                medicamento = Medicamento.objects.filter(nombre_producto=l)
                for m in medicamento:
                    total_gasto_med = total_gasto_med + m.precio_producto * mas_usados_tot[i]
                    print("Precio uni:", m.precio_producto, "Cantidad: ", mas_usados_tot[i])
                    i = i + 1

            print(mas_usados_tot)
            # print(total_gasto_med)
    return render(request, template_name="resumenes/resumen_costomed.html",
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy, 'resumen': resumen,
                           'total_gasto_med': total_gasto_med, 'prueba': prueba})


def obtener_resumen_ingresoConsultas(request):
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
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')

        if fecha_inicial and fecha_final:
            consultas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final])
            pagos = Pago.objects.filter(fechaPago__range=[fecha_inicial, fecha_final])
            # TABLA POR SEXO
            sexo_con_mas = consultas.filter(paciente__paciente__sexo='M').all()
            sexo_con_fem = consultas.filter(paciente__paciente__sexo='F').all()

            sexo_con_mas_num = sexo_con_mas.count()
            sexo_con_fem_num = sexo_con_fem.count()

            pagosM = pagos.filter(Expediente__paciente__sexo='M')
            total_consulta_mas = pagosM.aggregate(Sum("cantidad"))["cantidad__sum"]

            pagosF = pagos.filter(Expediente__paciente__sexo='F')
            total_consulta_fem = pagosF.aggregate(Sum("cantidad"))["cantidad__sum"]

            # TABLA POR EDAD

            fecha_menor = fecha_18()

            menores_con = consultas.filter(paciente__paciente__fechaNacimiento__gte=fecha_menor)
            mayores_con = consultas.filter(paciente__paciente__fechaNacimiento__lte=fecha_menor)
            edad_con_me = len(menores_con)
            edad_con_ma = len(mayores_con)

            total_consulta_men = \
                pagos.filter(Expediente__paciente__fechaNacimiento__gte=fecha_menor).aggregate(Sum("cantidad"))[
                    "cantidad__sum"]
            total_consulta_may = \
                pagos.filter(Expediente__paciente__fechaNacimiento__lte=fecha_menor).aggregate(Sum("cantidad"))[
                    "cantidad__sum"]

            # TABLA 3 TOTALES
            con_total = consultas.count()
            ingresos = pagos.aggregate(Sum("cantidad"))["cantidad__sum"]

        return render(request, template_name='resumenes/resumen_ingobtenidos.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'sexo_con_mas': sexo_con_mas_num, 'sexo_con_fem': sexo_con_fem_num,
                               'total_consulta_mas': total_consulta_mas, 'total_consulta_fem': total_consulta_fem,
                               'edad_con_me': edad_con_me, 'edad_con_ma': edad_con_ma, 'con_total': con_total,
                               'ingresos': ingresos, 'total_consulta_men': total_consulta_men,
                               "total_consulta_may": total_consulta_may})
    else:
        return render(request, template_name='resumenes/resumen_ingobtenidos.html')


def obtener_resumen_tratmientosreq(request):
    hoy = date.today()

    tratamientos_count = None
    tratamientos_pagados = None
    tratamientos_aplicados = None
    if request.method == 'POST':

        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')
        if fecha_inicial and fecha_final:
            tratamientos_aplicados = Tratamiento.objects.filter(
                nombreTratamiento=F('procedimiento__tratamiento__nombreTratamiento')).filter(
                procedimiento__consulta_realizada__fechaConsulta__range=[fecha_inicial, fecha_final])

            tratamientos_count = tratamientos_aplicados.values('nombreTratamiento', 'precioBase').annotate(
                count=Count('nombreTratamiento')).order_by('-count').annotate(
                total=ExpressionWrapper(F('count') * F('precioBase'), output_field=FloatField()))

            procedimientos_pagados = Procedimiento.objects.filter(pago__fechaPago__range=[fecha_inicial, fecha_final])
            tratamientos_pagados = procedimientos_pagados.filter(tratamiento__in=Tratamiento.objects.all()).values(
                'pago__cantidad',
                'tratamiento__nombreTratamiento',
                'tratamiento__precioBase').annotate(count=Count('tratamiento__nombreTratamiento')).order_by(
                '-count').annotate(
                total=ExpressionWrapper(F('count') * F('tratamiento__precioBase'), output_field=FloatField()))
            print(tratamientos_pagados)

            procedimientos_hechos = Procedimiento.objects.filter(
                consulta_realizada__fechaConsulta__range=[fecha_inicial, fecha_final])
            tratamientos_aplicados = procedimientos_hechos.filter(tratamiento__in=Tratamiento.objects.all()).values(
                'tratamiento__nombreTratamiento', 'tratamiento__precioBase').annotate(
                count=Count('tratamiento__nombreTratamiento')).order_by('-count')
            print(tratamientos_aplicados)

        return render(request, template_name='resumenes/resumen_tratamientosreq.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'tratamientos_count': tratamientos_count, 'tratamientos_pagados': tratamientos_pagados,
                               'tratamientos_aplicados': tratamientos_aplicados})
    else:
        return render(request, template_name='resumenes/resumen_tratamientosreq.html')
