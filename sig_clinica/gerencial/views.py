import collections
from datetime import datetime, date
from django.contrib.auth.decorators import login_required, user_passes_test
from django.db.models import Sum, Count, F, FloatField, ExpressionWrapper, Q
from django.shortcuts import render

from authentication.views import estrategico, administrador, tactico
from gerencial.models import Expediente, Paciente, Consulta, Medicamento, LoteMedicamento, Tratamiento, Odontograma, Bitacora
from gerencial.models import Procedimiento, Pago, Receta


def fecha_18():
    current = datetime.now().date()
    return date(current.year - 18, current.month, current.day)


# Create your views here
@login_required()
def index(request):
    return render(request, template_name='index.html')


# Funcion que obtiene el RESUMEN DE EXPEDIENTES CREADOS para un periodo
@user_passes_test(estrategico)
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
@user_passes_test(estrategico)
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


@user_passes_test(estrategico)
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

            # Lista de los producto sin repetir
            lista = list(dicc_mas_usados)

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


@user_passes_test(estrategico)
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

            # TABLA 2 INGRESOS OBTENIDOS POR CONSULTAS POR SEXO
            sexo_con_mas = consultas.filter(paciente__paciente__sexo='M').all()
            sexo_con_fem = consultas.filter(paciente__paciente__sexo='F').all()

            sexo_con_mas_num = sexo_con_mas.count()
            sexo_con_fem_num = sexo_con_fem.count()

            pagosM = pagos.filter(Expediente__paciente__sexo='M')
            total_consulta_mas = pagosM.aggregate(Sum("cantidad"))["cantidad__sum"]

            pagosF = pagos.filter(Expediente__paciente__sexo='F')
            total_consulta_fem = pagosF.aggregate(Sum("cantidad"))["cantidad__sum"]

            # TABLA 1 INGRESOS OBTENIDOS POR CONSULTAS POR EDAD

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


@user_passes_test(estrategico)
def obtener_resumen_tratmientosrec(request):
    hoy = date.today()
    tratamientos = None
    if request.method == 'POST':

        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')
        if fecha_inicial and fecha_final:

            # Tabla 1: 10 tratamientos recurrentes
            num = 10
            procedimientos_pagados = Procedimiento.objects.filter(pago__fechaPago__range=[fecha_inicial, fecha_final])
            tratamientos_pagados = procedimientos_pagados.filter(tratamiento__in=Tratamiento.objects.all()).values(
                'tratamiento__nombreTratamiento',
                'tratamiento__precioBase').annotate(count=Count('tratamiento__nombreTratamiento')).order_by(
                '-count').annotate(total_pagado=Sum('pago__cantidad'))

            procedimientos_hechos = Procedimiento.objects.filter(
                consulta_realizada__fechaConsulta__range=[fecha_inicial, fecha_final])
            tratamientos_aplicados = procedimientos_hechos.filter(tratamiento__in=Tratamiento.objects.all()).values(
                'tratamiento__nombreTratamiento', 'tratamiento__precioBase').annotate(
                count=Count('tratamiento__nombreTratamiento')).order_by('-count').annotate(
                total=ExpressionWrapper(F('count') * F('tratamiento__precioBase'), output_field=FloatField()))

            tratamientos = []
            test = {x['tratamiento__nombreTratamiento']: x for x in tratamientos_pagados}
            for item in tratamientos_aplicados:
                nombre = item['tratamiento__nombreTratamiento']
                if item['tratamiento__nombreTratamiento'] in test:
                    tratamientos.append({
                        'nombre': item['tratamiento__nombreTratamiento'],
                        'costo': item['tratamiento__precioBase'],
                        'total': test[nombre]['total_pagado'],
                        'cantidad': item['count'],
                        'ganancia': float(test[nombre]['total_pagado']) - item['total']
                    })
                else:
                    tratamientos.append({
                        'nombre': item['tratamiento__nombreTratamiento'],
                        'costo': item['tratamiento__precioBase'],
                        'total': 0,
                        'cantidad': item['count'],
                        'ganancia': - item['total']
                    })
            costo_total = 0
            total_pagado = 0
            tratamientos = tratamientos[:num]

            # TABLA 2 costo total en materiales/procedimientos, total pagado en tratamientos, ganancias totales
            for tratamiento in tratamientos:
                costo_total += tratamiento['costo'] * tratamiento['cantidad']
                total_pagado += tratamiento['total']

            ganancia_total = total_pagado - costo_total
        return render(request, template_name='resumenes/resumen_tratamientosreq.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'tratamientos': tratamientos, 'costo_total': costo_total, 'total_pagado': total_pagado,
                               'ganancia_total': ganancia_total})
    else:
        return render(request, template_name='resumenes/resumen_tratamientosreq.html')


@user_passes_test(tactico)
def obtener_informe_odontograma(request):
    hoy = date.today()

    if request.method == 'POST':
        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')

        # TABLA 1 TOTALES ODONTOGRAMAS USADOS Y CONSULTAS HECHAS
        num = 5
        consultas_realizadas = Consulta.objects.filter(fechaConsulta__range=[fecha_inicial, fecha_final])
        odontogramas = Odontograma.objects.filter(expediente__consulta__in=consultas_realizadas).filter(
            fechaUltimaModificacion__range=[fecha_inicial, fecha_final]).distinct()
        cant_consultas = consultas_realizadas.count()
        cant_odontogramas = odontogramas.count()

        consultas_fem = consultas_realizadas.filter(paciente__paciente__sexo='F').count()
        consultas_mas = consultas_realizadas.filter(paciente__paciente__sexo='M').count()

        total_consultas = consultas_mas + consultas_fem

        odontogramas_fem = odontogramas.filter(expediente__paciente__sexo='F').count()
        odontogramas_mas = odontogramas.filter(expediente__paciente__sexo='M').count()

        total_odontogramas = odontogramas_fem + odontogramas_mas

        tratamientos_frecuentes = Procedimiento.objects.filter(odontograma__in=odontogramas).values(
            'tratamiento__nombreTratamiento', 'tratamiento__precioBase').annotate(
            count=Count('tratamiento__nombreTratamiento')).order_by('-count')[:num]

        piezas_frecuentes = Procedimiento.objects.filter(odontograma__in=odontogramas).values(
            'tratamiento__nombreTratamiento', 'pieza').annotate(rep=Count('pieza')).order_by('-rep')

        print(piezas_frecuentes)

        tratamientos = []
        for tratamiento in tratamientos_frecuentes:
            tratamientos.append({
                "nombre": tratamiento['tratamiento__nombreTratamiento'],
                "piezas": [],
                "costo": tratamiento['tratamiento__precioBase']
            })

        for tratamiento in tratamientos:
            for s in piezas_frecuentes:
                if tratamiento['nombre'] == s['tratamiento__nombreTratamiento']:
                    if len(tratamiento['piezas']) <= num - 1:
                        tratamiento['piezas'].append(s['pieza'])

        return render(request, template_name='informes/uso_odontograma.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'tratamientos': tratamientos,
                               'cant_consultas': cant_consultas, 'cant_odontogramas': cant_odontogramas,
                               'total_contultas': total_consultas,
                               'total_odontogramas': total_odontogramas, 'consultas_fem': consultas_fem,
                               'consultas_mas': consultas_mas, 'odontogramas_fem': odontogramas_fem,
                               'odontogramas_mas': odontogramas_mas})
    else:
        return render(request, template_name='informes/uso_odontograma.html')


class RecetaMasUsados:
    def __init__(self, n, nombre, nombremed, marca, forma, precio):
        self.n = n
        self.nombre = nombre
        self.nombremed = nombremed
        self.marca = marca
        self.forma = forma
        self.precio = precio


# Resumen RecetaMed
@user_passes_test(tactico)
def obtener_resumen_recetamed(request):
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

            rec_deman_periodo = Receta.objects.filter(consulta__fechaConsulta__range=[fecha_inicial, fecha_final])
            # print(med_deman_periodo)

            lista_recetas = []
            for rec in rec_deman_periodo:
                lista_recetas.append(rec.nombreReceta)
            # print(lista_medicamentos)

            # Diccionario con frecuencia de aparicion de "lista_medicamentos", 'medicamento': frecuencia_de _uso
            dicc_mas_usados = collections.Counter(lista_recetas)  # Objeto counter
            prueba = collections.Counter(lista_recetas)

            # Lista de los producto sin repetir
            lista = list(dicc_mas_usados)

            # Obtiene una lista de 5 elemento ordenada de mayor a menos frecuencia de uso en recetas
            lista_mas_usados = []
            for ejecutar in range(8):
                i = 0
                for l in lista:
                    frecuencia_max = max(dicc_mas_usados.values())
                    frecuencia = dicc_mas_usados.get(l)
                    if frecuencia_max == frecuencia:
                        dicc_mas_usados.pop(l)
                        lista_mas_usados.append(l)
                        lista.pop(i)
                    i = i + 1

            mas_usados_rec = []
            if len(lista_mas_usados) >= 9:
                i = 0
                for rec in range(9):
                    mas_usados_rec.append(Receta.objects.get(
                        nombreReceta=lista_mas_usados[i]))
                    i = i + 1
                # print(mas_usados_med)
            else:
                i = 0
                for rec in range(len(lista_mas_usados)):
                    mas_usados_rec.append(Receta.objects.get(nombreReceta=lista_mas_usados[i]))
                    i = i + 1
                # print(mas_usados_med)

            # Totales de lotes
            mas_usados_tot = []
            # Comprobando que existen al menos 5 mediamentos mas tuilizados en recetas
            if len(lista_mas_usados) >= 9:
                i = 0
                for totales in range(9):
                    total = LoteMedicamento.objects.filter(
                        medicamento__receta__nombreReceta=lista_mas_usados[i]).aggregate(
                        Sum('cantidad'))
                    mas_usados_tot.append(total.get('cantidad__sum'))
                    i = i + 1
                # print(mas_usados_tot)
            else:
                i = 0
                for totales in range(len(lista_mas_usados)):
                    total = LoteMedicamento.objects.filter(
                        medicamento__receta__nombreReceta=lista_mas_usados[i]).aggregate(
                        Sum('cantidad'))
                    mas_usados_tot.append(total.get('cantidad__sum'))
                    i = i + 1
                # print(mas_usados_tot)

            # Aqui se llena los objetos que se enviaran al html, se envia "resumen"
            resumen = []
            i = 0
            # Comprobando que existen al menos 5 mediamentos mas tuilizados en recetas
            for medicamentos in range(len(mas_usados_rec)):
                meds = Medicamento.objects.filter(receta__nombreReceta=lista_mas_usados[i])
                i = i + 1

            if len(lista_mas_usados) >= 9:
                i = 0
                for repetir in range(9):
                    objeto = RecetaMasUsados(prueba.get(mas_usados_rec[i].nombreReceta),
                                             mas_usados_rec[i].nombreReceta, meds[i].nombre_producto,
                                             meds[i].marca_producto,
                                             meds[i].formafarmaceutica,
                                             meds[i].precio_producto)
                    resumen.append(objeto)
                    i = i + 1
            else:
                i = 0
                for repetir in range(len(lista_mas_usados)):
                    objeto = RecetaMasUsados(prueba.get(mas_usados_rec[i].nombreReceta),
                                             mas_usados_rec[i].nombreReceta, meds[i].nombre_producto,
                                             meds[i].marca_producto,
                                             meds[i].formafarmaceutica,
                                             meds[i].precio_producto)
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
                    total_gasto_med = total_gasto_med + \
                                      m.precio_producto * mas_usados_tot[i]
                    print("Precio uni:", m.precio_producto,
                          "Cantidad: ", mas_usados_tot[i])
                    i = i + 1

            print(mas_usados_tot)
            # print(total_gasto_med)
    return render(request, template_name="resumenes/resumen_recetamed.html",
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy, 'resumen': resumen,
                           'total_gasto_med': total_gasto_med, 'prueba': prueba})


class vencimiento:
    def __init__(self, nombre, marca, forma, precio, cantidadactual, vence):
        self.nombre = nombre
        self.marca = marca
        self.forma = forma
        self.precio = precio
        self.cantidadactual = cantidadactual
        self.vence = vence


# Resumen Vencimiento
@user_passes_test(tactico)
def obtener_resumen_vencimiento(request):
    fecha_inicial = ""
    fecha_final = ""
    hoy = date.today()

    resumen = ""
    tabla1 = ""

    medicamentoEntradoFiltrado = ""

    if request.method == 'POST':
        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')
        if fecha_inicial and fecha_final:
            # TABLA 1 MEDICAMENTOS MAS DEMANDADOS

            medicamentoEntradoFiltrado = Medicamento.objects.filter(lotemedicamento__fecha_entrada__range=[fecha_inicial, fecha_final],lotemedicamento__fecha_vencimiento__gt=fecha_final).annotate(count=Count('lotemedicamento__medicamento__nombre_producto')).annotate(total_cantidad=Sum('lotemedicamento__cantidad'))

            # print(total_gasto_med)
    return render(request, template_name="resumenes/resumen_vencimiento.html",
                  context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy, 'resumen': resumen,
                           'medicamentoEntradoFiltrado': medicamentoEntradoFiltrado, })


# Resumen NuevoRecurrente
@user_passes_test(tactico)
def obtener_resumen_nuevorecurrente(request):
    hoy = date.today()

    rsexo_con_mas_num = "NADA"
    rsexo_con_fem_num = ""

    rtotal_consulta_mas = 0
    rtotal_consulta_fem = 0

    redad_con_me = ""
    redad_con_ma = ""

    rtotal_consulta_men = 0
    rtotal_consulta_may = 0

    nsexo_con_mas_num = ""
    nsexo_con_fem_num = ""

    ntotal_consulta_mas = 0
    ntotal_consulta_fem = 0

    nedad_con_me = ""
    nedad_con_ma = ""

    ntotal_consulta_men = 0
    ntotal_consulta_may = 0

    con_total = 0
    ingresos = 0

    if request.method == 'POST':

        fecha_inicial = request.POST.get('fecha_inicial')
        fecha_final = request.POST.get('fecha_final')
        fecha_inicial = datetime.strptime(fecha_inicial, '%d/%m/%Y')
        fecha_final = datetime.strptime(fecha_final, '%d/%m/%Y')

        if fecha_inicial and fecha_final:
            rconsultas = Consulta.objects.filter(
                fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__expediente__fechaCreacion__lte=fecha_inicial)
            rpagos = Pago.objects.filter(
                fechaPago__range=[fecha_inicial, fecha_final]).filter(Expediente__fechaCreacion__lte=fecha_inicial)

            # TABLA POR SEXO RECURRENTE
            rsexo_con_mas = rconsultas.filter(paciente__paciente__sexo='M').all().filter(
                paciente__paciente__expediente__fechaCreacion__lte=fecha_inicial)
            rsexo_con_fem = rconsultas.filter(paciente__paciente__sexo='F').all().filter(
                paciente__paciente__expediente__fechaCreacion__lte=fecha_inicial)

            rsexo_con_mas_num = rsexo_con_mas.count()
            rsexo_con_fem_num = rsexo_con_fem.count()

            rpagosM = rpagos.filter(Expediente__paciente__sexo='M').filter(Expediente__fechaCreacion__lte=fecha_inicial)
            rtotal_consulta_mas = rpagosM.aggregate(
                Sum("cantidad"))["cantidad__sum"]

            rpagosF = rpagos.filter(Expediente__paciente__sexo='F').filter(
                Expediente__fechaCreacion__lte=fecha_inicial)
            rtotal_consulta_fem = rpagosF.aggregate(
                Sum("cantidad"))["cantidad__sum"]

            # TABLA POR EDAD RECURRENTE

            fecha_menor = fecha_18()

            rmenores_con = rconsultas.filter(
                paciente__paciente__fechaNacimiento__gte=fecha_menor).filter(
                paciente__paciente__expediente__fechaCreacion__lte=fecha_inicial)
            rmayores_con = rconsultas.filter(
                paciente__paciente__fechaNacimiento__lte=fecha_menor).filter(
                paciente__paciente__expediente__fechaCreacion__lte=fecha_inicial)
            redad_con_me = len(rmenores_con)
            redad_con_ma = len(rmayores_con)

            rtotal_consulta_men = \
                rpagos.filter(Expediente__paciente__fechaNacimiento__gte=fecha_menor).filter(
                    Expediente__fechaCreacion__lte=fecha_inicial).aggregate(Sum("cantidad"))[
                    "cantidad__sum"]
            rtotal_consulta_may = \
                rpagos.filter(Expediente__paciente__fechaNacimiento__lte=fecha_menor).filter(
                    Expediente__fechaCreacion__lte=fecha_inicial).aggregate(Sum("cantidad"))[
                    "cantidad__sum"]

            consultas = Consulta.objects.filter(
                fechaConsulta__range=[fecha_inicial, fecha_final])
            pagos = Pago.objects.filter(
                fechaPago__range=[fecha_inicial, fecha_final])

            # PARA NUEVO
            nconsultas = Consulta.objects.filter(
                fechaConsulta__range=[fecha_inicial, fecha_final]).filter(
                paciente__paciente__expediente__fechaCreacion__gte=fecha_inicial)
            npagos = Pago.objects.filter(
                fechaPago__range=[fecha_inicial, fecha_final]).filter(Expediente__fechaCreacion__gte=fecha_inicial)

            # TABLA POR SEXO NUEVO
            nsexo_con_mas = nconsultas.filter(paciente__paciente__sexo='M').all().filter(
                paciente__paciente__expediente__fechaCreacion__gte=fecha_inicial)
            nsexo_con_fem = nconsultas.filter(paciente__paciente__sexo='F').all().filter(
                paciente__paciente__expediente__fechaCreacion__gte=fecha_inicial)

            nsexo_con_mas_num = nsexo_con_mas.count()
            nsexo_con_fem_num = nsexo_con_fem.count()

            npagosM = npagos.filter(Expediente__paciente__sexo='M').filter(
                Expediente__fechaCreacion__gte=fecha_inicial)
            ntotal_consulta_mas = npagosM.aggregate(
                Sum("cantidad"))["cantidad__sum"]

            npagosF = npagos.filter(Expediente__paciente__sexo='F').filter(
                Expediente__fechaCreacion__gte=fecha_inicial)
            ntotal_consulta_fem = npagosF.aggregate(
                Sum("cantidad"))["cantidad__sum"]

            # TABLA POR EDAD NUEVO

            fecha_menor = fecha_18()

            nmenores_con = nconsultas.filter(
                paciente__paciente__fechaNacimiento__gte=fecha_menor).filter(
                paciente__paciente__expediente__fechaCreacion__gte=fecha_inicial)
            nmayores_con = nconsultas.filter(
                paciente__paciente__fechaNacimiento__lte=fecha_menor).filter(
                paciente__paciente__expediente__fechaCreacion__gte=fecha_inicial)
            nedad_con_me = len(nmenores_con)
            nedad_con_ma = len(nmayores_con)

            ntotal_consulta_men = \
                npagos.filter(Expediente__paciente__fechaNacimiento__gte=fecha_menor).filter(
                    Expediente__fechaCreacion__gte=fecha_inicial).aggregate(Sum("cantidad"))[
                    "cantidad__sum"]
            ntotal_consulta_may = \
                npagos.filter(Expediente__paciente__fechaNacimiento__lte=fecha_menor).filter(
                    Expediente__fechaCreacion__gte=fecha_inicial).aggregate(Sum("cantidad"))[
                    "cantidad__sum"]

            consultas = Consulta.objects.filter(
                fechaConsulta__range=[fecha_inicial, fecha_final])
            pagos = Pago.objects.filter(
                fechaPago__range=[fecha_inicial, fecha_final])

            # TABLA 3 TOTALES
            con_total = consultas.count()
            ingresos = pagos.aggregate(Sum("cantidad"))["cantidad__sum"]

        return render(request, template_name='resumenes/resumen_nuevorecurrente.html',
                      context={'fecha_inicial': fecha_inicial, 'fecha_final': fecha_final, 'hoy': hoy,
                               'rsexo_con_mas': rsexo_con_mas_num, 'rsexo_con_fem': rsexo_con_fem_num,
                               'rtotal_consulta_mas': rtotal_consulta_mas, 'rtotal_consulta_fem': rtotal_consulta_fem,
                               'nsexo_con_mas': nsexo_con_mas_num, 'nsexo_con_fem': nsexo_con_fem_num,
                               'ntotal_consulta_mas': ntotal_consulta_mas, 'ntotal_consulta_fem': ntotal_consulta_fem,
                               'redad_con_me': redad_con_me, 'redad_con_ma': redad_con_ma, 'con_total': con_total,
                               'nedad_con_me': nedad_con_me, 'nedad_con_ma': nedad_con_ma,
                               'ingresos': ingresos, 'rtotal_consulta_men': rtotal_consulta_men,
                               "rtotal_consulta_may": rtotal_consulta_may, 'ntotal_consulta_men': ntotal_consulta_men,
                               "ntotal_consulta_may": ntotal_consulta_may})
    else:
        return render(request, template_name='resumenes/resumen_nuevorecurrente.html')


def registro_bitacora(request, accion):
    user = request.user
    Bitacora.objects.create(
        usuario=user,
        accion=accion,
        fecha=datetime.datetime.now()
    )
    return 0


@login_required
@user_passes_test(administrador)
def bitacora(request):
    object_list = []
    c = {}
    consultas = Bitacora.objects.raw(
        "SELECT DISTINCT auth_group.name, gerencial_bitacora.* FROM auth_user_groups JOIN  gerencial_bitacora on user_id = usuario_id Join auth_group on group_id=auth_group.id;")

    object_list = list(consultas)
    # Contexto
    c['object_list'] = object_list

    c['columnas'] = ["Nombre se Usuario", "Accion", "Fecha", "Rol"]
    c['title'] = "Bitacora de Usuarios"

    return render(request, 'gerencial/bitacora.html', c)
