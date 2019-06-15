
var fechai = document.getElementById('fecha_inicial').value;
var fechaf = document.getElementById('fecha_final').value;



function obtenerFechas() {
    //console.log(fechai)
    //console.log('hola')
    var fechai = document.getElementById('fecha_inicial').value;
    var fechaf = document.getElementById('fecha_final').value;

        if( fechai != "" ) {
            //alert(fechai)
        }else{
            //alert('Vacío')
    }



    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {

           respuesta = JSON.parse(xhttp.responseText)
           console.log(respuesta)

        }

    var fechas = {
        fecha_inicial: fechai,
        fecha_final: fechaf
        }
    }
    //xhttp.open("GET", "resumen_expcreados/"+fechai+"/", true);
    xhttp.open("GET", "resumen_expcreados/"+fechai+"/"+fechaf+"/", true);
    xhttp.send();

}


