from .tablaDestino import TablaDestino
from .atributoDestino import AtributoDestino
from .tablaOrigen import TablaOrigen
class Configuracion:

#   Credenciales de base de datos Origen
    USER_SOURCE='clinica_user'
    PASSWORD_SOURCE='admin123'
    DATABASE_SOURCE='clinica_db'
#   Credenciales de base de datos Destino
    USER_DESTINATION='clinica_user'
    PASSWORD_DESTINATION='admin123'
    DATABASE_DESTINATION='bd_sig'


    def getTables():
        doctor=TablaDestino("gerencial_doctor",[
                AtributoDestino('id',TablaOrigen('transaccional_doctor','id')),
                AtributoDestino('nombre',TablaOrigen('transaccional_doctor','nombre'),'string')
                        ])
        medicamento = TablaDestino("gerencial_medicamento",[
                AtributoDestino('id',TablaOrigen('transaccional_medicamento','id')),
                AtributoDestino('nombre_producto',TablaOrigen('transaccional_medicamento','nombre_producto'),'string'),
                AtributoDestino('marca_producto',TablaOrigen('transaccional_medicamento','marca_producto'),'string'),
                AtributoDestino('existencia_producto',TablaOrigen('transaccional_medicamento','existencia_producto')),
                AtributoDestino('precio_producto',TablaOrigen('transaccional_medicamento','precio_producto')),
                AtributoDestino('formafarmaceutica', TablaOrigen('transaccional_medicamento', 'formafarmaceutica'),'string')                
                        ])

        lotemedicamento = TablaDestino("gerencial_lotemedicamento",[
                AtributoDestino('id',TablaOrigen('transaccional_lotemedicamento','id')),
                AtributoDestino('fecha_vencimiento',TablaOrigen('transaccional_lotemedicamento','fecha_vencimiento'),'string'),
                AtributoDestino('cantidad',TablaOrigen('transaccional_lotemedicamento','cantidad')),
                AtributoDestino('medicamento_id',TablaOrigen('transaccional_lotemedicamento','medicamento_id')),
                AtributoDestino('fecha_entrada',TablaOrigen('transaccional_lotemedicamento','fecha_vencimiento'),'string'),
                ])

        odontograma = TablaDestino("gerencial_odontograma",[
                AtributoDestino('id',TablaOrigen('transaccional_odontograma','id')),
                AtributoDestino('fechaCreacion',TablaOrigen('transaccional_odontograma','fechaCreacion'),'string'),
                AtributoDestino('notas',TablaOrigen('transaccional_odontograma','notas'),'string'),
                AtributoDestino('medico_id',TablaOrigen('transaccional_odontograma','medico_id')),
                AtributoDestino('fechaUltimaModificacion',TablaOrigen('transaccional_odontograma','fechaUltimaModificacion'),'string'),
                ])
        
        paciente = TablaDestino("gerencial_paciente",[
                AtributoDestino('id',TablaOrigen('transaccional_paciente','id')),
                AtributoDestino('nombresPaciente',TablaOrigen('transaccional_paciente','nombresPaciente'),'string'),
                AtributoDestino('apellidosPaciente',TablaOrigen('transaccional_paciente','apellidosPaciente'),'string'),
                AtributoDestino('sexo',TablaOrigen('transaccional_paciente','sexo'), 'string'),
                AtributoDestino('fechaNacimiento',TablaOrigen('transaccional_paciente','fechaNacimiento'),'string'),
                AtributoDestino('referencia',TablaOrigen('transaccional_paciente','referencia'),'string')
                ])

        expediente = TablaDestino("gerencial_expediente",[
                AtributoDestino('id',TablaOrigen('transaccional_expediente','id')),
                AtributoDestino('fechaCreacion',TablaOrigen('transaccional_expediente','fechaCreacion'),'string'),
                AtributoDestino('pagado',TablaOrigen('transaccional_expediente','pagado'),'string'),
                AtributoDestino('saldo',TablaOrigen('transaccional_expediente','saldo'),),
                AtributoDestino('observacionExp',TablaOrigen('transaccional_expediente','observacionExp'),'string'),
                AtributoDestino('odontograma_id',TablaOrigen('transaccional_expediente','odontograma_id')),
                AtributoDestino('paciente_id',TablaOrigen('transaccional_expediente','paciente_id'))
                ])
        cita = TablaDestino("gerencial_cita",[
                AtributoDestino('id',TablaOrigen('transaccional_cita','id')),
                AtributoDestino('asuntoCita',TablaOrigen('transaccion_cita','asuntoCita'),'string'),
                AtributoDestino('fechaCita',TablaOrigen('transaccional_cita','fechaCita'),'string'),
                AtributoDestino('horaCita',TablaOrigen('transaccional_cita','horaCita'),'string'),
                AtributoDestino('observacionCita',TablaOrigen('transaccional_cita','observacionCita'),'string'),
                AtributoDestino('doctor_id',TablaOrigen('transaccional_cita','doctor_id')),
                AtributoDestino('paciente_id',TablaOrigen('transaccional_cita','paciente_id'))
                ])
        tratamiento = TablaDestino("gerencial_tratamiento",[
                AtributoDestino('id',TablaOrigen('transaccional_tratamiento','id')),
                AtributoDestino('nombreTratamiento',TablaOrigen('transaccion_tratamiento','nombreTratamiento'),'string'),
                AtributoDestino('descripcionTratamiento',TablaOrigen('transaccional_tratamiento','descripcionTratamiento'),'string'),
                AtributoDestino('precioBase',TablaOrigen('transaccional_tratamiento','precioBase'),'string')
                ])

        consulta = TablaDestino("gerencial_consulta",[
                AtributoDestino('id',TablaOrigen('transaccional_consulta','id')),
                AtributoDestino('fechaConsulta',TablaOrigen('transaccion_consulta','fechaConsulta'),'string'),
                AtributoDestino('horaInicio',TablaOrigen('transaccional_consulta','horaInicio'),'string'),
                AtributoDestino('horaFinal',TablaOrigen('transaccional_consulta','horaFinal'),'string'),
                AtributoDestino('observacionCons',TablaOrigen('transaccional_consulta','observacionCons'),'string'),
                AtributoDestino('doctor_id',TablaOrigen('transaccional_consulta','doctor_id')),
                AtributoDestino('paciente_id',TablaOrigen('transaccional_consulta','paciente_id')),
                AtributoDestino('precio',TablaOrigen('transaccional_consulta','precio')),
                ])

        procedimiento = TablaDestino("gerencial_procedimiento",[
                AtributoDestino('id',TablaOrigen('transaccional_procedimiento','id')),
                AtributoDestino('pieza',TablaOrigen('transaccional_procedimiento','pieza'),'string'),
                AtributoDestino('cara',TablaOrigen('transaccional_procedimiento','cara'),'string'),
                AtributoDestino('diagnostico',TablaOrigen('transaccional_procedimiento','diagnostico'), 'string'),
                AtributoDestino('notas',TablaOrigen('transaccional_procedimiento','notas'),'string'),
                AtributoDestino('status',TablaOrigen('transaccional_procedimiento','status'),'string'),
                AtributoDestino('odontograma_id',TablaOrigen('transaccional_procedimiento','odontograma_id')),
                AtributoDestino('tratamiento_id',TablaOrigen('transaccional_procedimiento','tratamiento_id')),
                AtributoDestino('consulta_realizada_id',TablaOrigen('transaccional_procedimiento','consulta_realizada_id')),
                ])

        pago = TablaDestino("gerencial_pago",[
                AtributoDestino('id',TablaOrigen('transaccional_pago','id')),
                AtributoDestino('fechaPago',TablaOrigen('transaccional_pago','fechaPago'),'string'),
                AtributoDestino('cantidad',TablaOrigen('transaccional_pago','cantidad'),'string'),
                AtributoDestino('Expediente_id',TablaOrigen('transaccional_pago','Expediente_id')),
                AtributoDestino('procedimiento_id',TablaOrigen('transaccional_pago','Expediente_id')),
                ])
        
        receta = TablaDestino("gerencial_receta",[
                AtributoDestino('id',TablaOrigen('transaccional_receta','id')),
                AtributoDestino('consulta_id',TablaOrigen('transaccional_receta','consulta_id')),
                AtributoDestino('nombreReceta',TablaOrigen('transaccional_receta','nombreReceta'),'string'),
                ])

        especificacion = TablaDestino("gerencial_especificacion",[
                AtributoDestino('id',TablaOrigen('transaccional_especificacion','id')),
                AtributoDestino('dosis',TablaOrigen('transaccional_especificacion','dosis'),'string'),
                AtributoDestino('duracion',TablaOrigen('transaccional_especificacion','duracion'),'string'),
                AtributoDestino('medicamento_id',TablaOrigen('transaccional_especificacion','medicamento_id')),
                AtributoDestino('receta_id',TablaOrigen('transaccional_especificacion','receta_id')),
                ])

        entidades=[]
        entidades.append(doctor)
        entidades.append(medicamento)
        entidades.append(lotemedicamento)
        entidades.append(odontograma)
        entidades.append(paciente)
        entidades.append(expediente)
        entidades.append(cita)
        entidades.append(tratamiento)
        entidades.append(consulta)
        entidades.append(procedimiento)
        #entidades.append(pago)
        entidades.append(receta)
        entidades.append(especificacion)
        return entidades