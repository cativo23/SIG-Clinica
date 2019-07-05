
class Cargar:
    def cargarModelos(objetos,cursor):
        for objeto in list(reversed(objetos)):
            drop="DELETE  FROM "+objeto.nombre+" ORDER BY id DESC"
            cursor.execute(drop)
            print(drop)
        #print(len(objetos[0].datos))
        for objeto in objetos:
            #print(objeto.datos)
            #print(str(objeto[1]))
            print('==Insert== \n'+"=========="+objeto.nombre+"==========")
            for i in range(len(objeto.datos)):
                #print(objeto.datos[0][0].tipo)
                #print (i)
                query = 'INSERT INTO ' + objeto.nombre + ' VALUES ('
                for j in range(len(objeto.datos[i])):
                    #print (i)
                    if(j!=0):
                        query=query+','
                    if objeto.datos[i][j]==None:
                        query = query + 'Null'
                    elif objeto.atributos[j].tipo=='string' and objeto.datos[i][j] is not None:
                        query=query+"'"+str(objeto.datos[i][j])+"'"
                    else:
                        query = query + str(objeto.datos[i][j])



                query=query+');\n'
                print (query)
                cursor.execute(query)


