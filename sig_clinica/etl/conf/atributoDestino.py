#from .tabla import Tabla
from .tablaOrigen import TablaOrigen
class AtributoDestino:
               nombre=" "
               tablaOrigen=None
               tipo=None

               def __init__(self,nombre,tablaOrigen=None,tipo=None):
                       self.nombre=nombre
                       self.tipo = tipo
                       self.tablaOrigen=tablaOrigen

