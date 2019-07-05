#from .atributo import Atributo

class TablaDestino:
    nombre = " "
    atributos = []
    datos=[]
    funcion=False
    atributo=''
    proceso=''

    def __init__(self,nombre,atributos,funcion=False,atributo=None,proceso=None):
        self.nombre=nombre
        self.atributos=atributos
        self.funcion=funcion
        self.atributo=atributo
        self.proceso=proceso


    def setDato(self,datos):
        #print (datos)
        self.datos.append(datos)

