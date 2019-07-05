import psycopg2
from etl.conf.configuracion import Configuracion
from etl.extraer.extraer import Extraer
from etl.cargar.cargar import Cargar


def run()\
        :
    try:
        cnx = psycopg2.connect(user=Configuracion.USER_SOURCE, password=Configuracion.PASSWORD_SOURCE,
                               database=Configuracion.DATABASE_SOURCE)
        cny = psycopg2.connect(user=Configuracion.USER_DESTINATION, password=Configuracion.PASSWORD_DESTINATION,
                               database=Configuracion.DATABASE_DESTINATION)
        cursor1 = cnx.cursor(buffered=True)
        cursor2 = cny.cursor(buffered=True)
        Cargar.cargarModelos(Extraer.obtenerModelos(Configuracion.getTables(), cursor1), cursor2)
        cny.commit()
        cursor1.close()
        cursor2.close()
        cnx.close()
        cny.close()
        print("=============================================================="
              "==================================\n=========================="
              "  ETL ejecutado con exito :)   ==================================")
    except (Exception, psycopg2.Error) as error:
        print('Error', error)
