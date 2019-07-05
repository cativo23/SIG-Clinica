from .tablaDestino import TablaDestino
from .atributoDestino import AtributoDestino
from .tablaOrigen import TablaOrigen
class Configuracion:

#   Credenciales de base de datos Origen
    USER_SOURCE='clinica_usser'
    PASSWORD_SOURCE='admin123'
    DATABASE_SOURCE='clinica_db'
#   Credenciales de base de datos Destino
    USER_DESTINATION='clinica_user'
    PASSWORD_DESTINATION='admin123'
    DATABASE_DESTINATION='bd_sig'


    def getTables():
        departamento=TablaDestino("gerencial_departamento",[
                AtributoDestino('id',TablaOrigen('administracion_departamento','id')),
                AtributoDestino('nombre',TablaOrigen('administracion_departamento','nombre'),'string')
                        ])
        municipio=TablaDestino("gerencial_municipio",[
                AtributoDestino('id',TablaOrigen('administracion_municipio','id')),
                AtributoDestino('nombre',TablaOrigen('administracion_municipio','nombre'),'string'),
                AtributoDestino('departamento_id',TablaOrigen('administracion_municipio','departamento_id'))

                        ])
        donacion=TablaDestino('gerencial_donacion',[
            AtributoDestino('id',TablaOrigen('donaciones_donacion','id')),
            AtributoDestino('fecha_remesa', TablaOrigen('donaciones_donacion', 'fecha_remesa'), 'string'),
            AtributoDestino('cantidad',TablaOrigen('donaciones_donacion','cantidad'))
                        ])
        cita_medica=TablaDestino('gerencial_citamedica',[
            AtributoDestino('id',TablaOrigen('control_citamedica','id')),
            AtributoDestino('fecha',TablaOrigen('control_citamedica','fecha'),'string'),
            AtributoDestino('precio_consulta', TablaOrigen('control_citamedica', 'precio_consulta')),
            AtributoDestino('precio_examen', TablaOrigen('control_citamedica', 'precio_examen')),
            AtributoDestino('examen_id', TablaOrigen('control_citamedica', 'examen_id')),
            AtributoDestino('medico_id', TablaOrigen('control_citamedica', 'medico_id')),
            AtributoDestino('plan_tratamiento_id', TablaOrigen('control_citamedica', 'plan_tratamiento_id'))
                        ])
        empleado=TablaDestino('gerencial_empleado',[
            AtributoDestino('id',TablaOrigen('administracion_empleado','id')),
            AtributoDestino('especialidad_id',TablaOrigen('administracion_empleado','especialidad_id'))
        ])

        especialidad=TablaDestino('gerencial_especialidad',[
            AtributoDestino('id',TablaOrigen('administracion_especialidad','id')),
            AtributoDestino('nombre',TablaOrigen('administracion_especialidad','nombre'),'string')
        ])
        planTratamiento=TablaDestino('gerencial_plantratamiento',[
            AtributoDestino('id',TablaOrigen('control_plantratamiento','id')),
            AtributoDestino('fecha_inicio', TablaOrigen('control_plantratamiento', 'fecha_inicio'), 'string'),
            AtributoDestino('fecha_fin',TablaOrigen('control_plantratamiento','fecha_fin'),'string'),
            AtributoDestino('estado', TablaOrigen('control_plantratamiento', 'estado'), 'string'),
            AtributoDestino('expediente_id',TablaOrigen('control_plantratamiento','expediente_id'))
        ])
        examen=TablaDestino('gerencial_examen',[
            AtributoDestino('id',TablaOrigen('control_examen','id')),
            AtributoDestino('nombre',TablaOrigen('control_examen','nombre'),'string'),
            AtributoDestino('estado',TablaOrigen('control_examen','estado'),'string') #NOTA: incluir atributo en el modelo
        ])
        paciente=TablaDestino('gerencial_paciente',[
            AtributoDestino('id',TablaOrigen('administracion_paciente','id')),
            AtributoDestino('fecha_nacimiento',TablaOrigen('administracion_paciente','fecha_nacimiento'),'string'),
            AtributoDestino('sexo',TablaOrigen('administracion_paciente','sexo'),'string'),
            AtributoDestino('municipio_id',TablaOrigen('administracion_paciente','municipio_id'))
        ])
        expediente=TablaDestino('gerencial_expediente',[
            AtributoDestino('id',TablaOrigen('administracion_expediente','id')),
            AtributoDestino('num_expediente',TablaOrigen('administracion_expediente','num_expediente'),'string'),
            AtributoDestino('fecha_apertura',TablaOrigen('administracion_expediente','fecha_apertura'),'string'),
            AtributoDestino('empleado_id',TablaOrigen('administracion_expediente','creado_por_id')),
            AtributoDestino('paciente_id', TablaOrigen('administracion_expediente', 'paciente_id')),
            AtributoDestino('tarifa_id',TablaOrigen('administracion_expediente','id',TablaOrigen('administracion_socioeconomico','tarifa_id')))
        ])
        medicamento=TablaDestino('gerencial_medicamento',[
            AtributoDestino('id',TablaOrigen('control_medicamento','id')),
            AtributoDestino('nombre',TablaOrigen('control_medicamento','nombre'),'string'),
            AtributoDestino('estado',TablaOrigen('control_medicamento','estado'),'string')
        ])
        tarifa=TablaDestino('gerencial_tarifa',[
            AtributoDestino('id',TablaOrigen('administracion_tarifa','id')),
            AtributoDestino('nombre', TablaOrigen('administracion_tarifa','nombre'),'string'),
            AtributoDestino('monto', TablaOrigen('administracion_tarifa','monto')),
            AtributoDestino('examen_id', TablaOrigen('administracion_tarifa','examen_id')),
            AtributoDestino('tarifa_padre_id', TablaOrigen('administracion_tarifa','tarifa_padre_id'))
        ])
        grupoApoyo=TablaDestino('gerencial_grupoapoyo',[
            AtributoDestino('id', TablaOrigen('administracion_grupoapoyo','id')),
            AtributoDestino('tema', TablaOrigen('administracion_grupoapoyo','tema'),'string'),
            AtributoDestino('fecha',TablaOrigen('administracion_grupoapoyo','fecha'),'string'),
            AtributoDestino('ponente', TablaOrigen('administracion_grupoapoyo','ponente_id',TablaOrigen('administracion_ponente','nombre')),'string'),
            AtributoDestino('cantidad',TablaOrigen('administracion_grupoapoyo','id',TablaOrigen('administracion_grupoapoyo_participantes','grupoapoyo_id')))
        ],True,'cantidad','SELECT administracion_grupoapoyo.id,administracion_grupoapoyo.tema,administracion_grupoapoyo.fecha,administracion_ponente.nombre,count(c.grupoapoyo_id)  from administracion_grupoapoyo natural JOIN administracion_ponente LEFT JOIN (SELECT id,grupoapoyo_id FROM administracion_grupoapoyo_pacientes UNION ALL  SELECT id,grupoapoyo_id FROM administracion_grupoapoyo_participantes) AS c ON administracion_grupoapoyo.id=c.grupoapoyo_id group by administracion_grupoapoyo.id,administracion_grupoapoyo.tema,administracion_grupoapoyo.fecha')

        loteMedicamento=TablaDestino('gerencial_lotemedicamento',[
            AtributoDestino('id',TablaOrigen('control_lotemedicamento','id')),
            AtributoDestino('fecha_vencimiento',TablaOrigen('control_lotemedicamento','fecha_vencimiento'),'string'),
            AtributoDestino('cantidad',TablaOrigen('control_lotemedicamento','cantidad_ingreso')),
            AtributoDestino('medicamento_id',TablaOrigen('control_lotemedicamento','medicamento_id'))
        ])

        planTratamiento=TablaDestino('gerencial_plantratamiento',[
            AtributoDestino('id',TablaOrigen('control_plantratamiento','id')),
            AtributoDestino('fecha_inicio', TablaOrigen('control_plantratamiento', 'fecha_inicio'), 'string'),
            AtributoDestino('fecha_fin', TablaOrigen('control_plantratamiento', 'fecha_fin'), 'string'),
            AtributoDestino('estado', TablaOrigen('control_plantratamiento', 'estado')),
            AtributoDestino('expediente_id', TablaOrigen('control_plantratamiento', 'expediente_id'))
        ])

        citaMedica=TablaDestino('genencial_citamedica',[
            AtributoDestino('id',TablaOrigen('control_citamedica','id')),
            AtributoDestino('fecha',TablaOrigen('control_citamedica','fecha')),
            AtributoDestino('precio_consulta',TablaOrigen('control_citamedica','precio_consulta')),
            AtributoDestino('precio_examen', TablaOrigen('control_citamedica', 'precio_examen')),
            AtributoDestino('examen_id', TablaOrigen('control_citamedica', 'examen_id')),
            AtributoDestino('medico_id', TablaOrigen('control_citamedica', 'medico_id')),
            AtributoDestino('plan_tratamiento_id', TablaOrigen('control_citamedica', 'plan_tratamiento_id'))
        ])

        salida=TablaDestino('gerencial_salida',[
            AtributoDestino('id',TablaOrigen('donaciones_detallesalida','id')),
            AtributoDestino('fecha',TablaOrigen('donaciones_detallesalida', 'fecha', TablaOrigen('donaciones_salida', 'fecha')),'string'),
            AtributoDestino('cantidad',TablaOrigen('donaciones_detallesalida','cantidad')),
            AtributoDestino('medicamento_id',TablaOrigen('donaciones_detallesalida','medicamento_id'))
        ])





        entidades=[]
        entidades.append(medicamento)
        entidades.append(donacion)
        entidades.append(especialidad)
        entidades.append(empleado)
        entidades.append(departamento)
        entidades.append(municipio)
        entidades.append(paciente)
        entidades.append(examen)
        entidades.append(tarifa)
        entidades.append(expediente)
        entidades.append(grupoApoyo)
        entidades.append(loteMedicamento)
        entidades.append(planTratamiento)
        entidades.append(cita_medica)
        entidades.append(salida)


        return entidades