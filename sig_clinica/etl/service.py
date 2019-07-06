import psycopg2
from .conf.configuracion import Configuracion
from .extraer.extraer import Extraer
from .cargar.cargar import Cargar


def run():
    try:
        cnx = psycopg2.connect(user=Configuracion.USER_SOURCE, password=Configuracion.PASSWORD_SOURCE, host='localhost',
                               database=Configuracion.DATABASE_SOURCE)
        cny = psycopg2.connect(user=Configuracion.USER_DESTINATION, password=Configuracion.PASSWORD_DESTINATION, host = 'localhost',
                               database=Configuracion.DATABASE_DESTINATION)
        cursor1 = cnx.cursor()
        cursor2 = cny.cursor()
        Cargar.cargarModelos(Extraer.obtenerModelos(Configuracion.getTables(), cursor1), cursor2)
        cny.commit()
        cursor1.close()
        cursor2.close()
        cnx.close()
        cny.close()
        print("=============================================================="
              "==================================\n=========================="
              "  ETL ejecutado con exito :)   ==================================")
        return 1
    except (Exception, psycopg2.Error) as error:
        print('Error', error)
        return 0
