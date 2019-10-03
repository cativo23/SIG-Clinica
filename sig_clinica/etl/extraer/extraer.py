#from ..conf.configuracion import Configuracion
class Extraer:
    def obtenerModelos(tablas_destino,cursor):
        #Inicializa la lista de tablas destino
        modelos=[]
        #Iterar las tablas destino qeu corresponderan
        for  tablas in tablas_destino:
            #Inicializa con falso la posibilidad de que hay que hacer JOIN sobre las tablas
            anidado = False
            #Inicializa las tablas Anidadas que podrian tener
            tablasAnidadas = []
            #tablas para filtrar
            atributosCruzados=[]
            #Inicializa la sentencia para la consulta
            query = 'SELECT '
            #Inicializa el contador para iterar las tablas destino
            i=0
            while(i<len(tablas.atributos)):
                #print(tablas.atributos[i].tablaOrigen.nombre)

                #Verifica si si quere acceder a otra tabla mediante una llave foranea
                if tablas.atributos[i].tablaOrigen.tablaOrigen is not None :
                    anidado=True
                    pivote=tablas.atributos[i].tablaOrigen

                    atributosCruzados.append(tablas.atributos[i])
                    #Sigue iterando si hay mas objetos anidados
                    while anidado:
                        print("Iterando objeto anidado:"+pivote.nombre)
                        if pivote.tablaOrigen==None :
                            if tablas.proceso is not None:
                                print(tablas.atributos[i].nombre +"prueba="+tablas.proceso)
                            if tablas.funcion==True and tablas.atributos[i].nombre == tablas.atributo:
                                query=query+tablas.proceso+'('+pivote.nombre+'.'+pivote.atributoOrigen+')'
                                anidado=False
                            else:
                                query = query + pivote.nombre + '.' + pivote.atributoOrigen
                                anidado=False
                        else:
                            pivote=pivote.tablaOrigen
                            tablasAnidadas.append(pivote.nombre)
                else:
                    query =query + '\"'+ tablas.atributos[i].tablaOrigen.atributoOrigen+'\"'
                i = i + 1
                if(i!=len(tablas.atributos)):
                    query=query+','

            query = query + " FROM " + '\"' + tablas.atributos[0].tablaOrigen.nombre+'\"'
            #####Para agregar el where e parte de las tablas
            if tablas.proceso:
                query=query+  ' NATURAL JOIN administracion_ponente LEFT JOIN administracion_grupoapoyo_participantes     ON '
            if len(tablasAnidadas)>0:
                #Concatena el JOIN en caso de tener mas tablas anidadas
                if tablas.funcion:
                    query=tablas.proceso

                else:
                    for anidada in tablasAnidadas:
                       query=query+" NATURAL LEFT JOIN "+anidada

            print('======QUERY=======\n'+query)
            #Ejecuta la sentencia
            cursor.execute(query)
            #print(tablas.nombre+'-----')
            tablas.datos=[]
            for modelo in cursor:
                print(modelo)
                #print(tablas.nombre+"==prueba==")
                tablas.setDato(modelo)
            modelos.append(tablas)

            #print(datos)
        return modelos


