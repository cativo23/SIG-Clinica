  document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.datepicker1');
    var instances1 = M.Datepicker.init(elems, {
        format: 'dd/mm/yyyy',
        firstDay: 1,
        i18n: {
            months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',  'Julio', 'Agosto', 'Septiembre',
                    'Octubre', 'Noviembre', 'Diciembre'],
            monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',  'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            weekdays: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
            weekdaysAbbrev: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
            cancel: 'Cancelar',
            done: 'Aceptar',
        },
        maxDate: new Date(),
        onSelect: function(time){
            var dat = time.getDate()+'/'+(time.getMonth()+1)+"/"+time.getFullYear();
            var elem = document.querySelectorAll('.datepicker2');
            var instance = M.Datepicker.getInstance(elem[0]);
            var dat1 = instance.date;
            console.log(dat1 < time);
            if (dat1 < time){
                instance.date = time;
                instance.gotoDate(time);
                document.getElementById('fecha_final').value = dat;
            }else{
                instance.gotoDate(dat1);
            }
            instance.options.minDate = time;
        }
    });

    var elems2 = document.querySelectorAll('.datepicker2');
    var instances = M.Datepicker.init(elems2, {
        format: 'dd/mm/yyyy',
        firstDay: 1,
        i18n: {
            months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',  'Julio', 'Agosto', 'Septiembre',
                    'Octubre', 'Noviembre', 'Diciembre'],
            monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',  'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            weekdays: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
            weekdaysAbbrev: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
            cancel: 'Cancelar',
            done: 'Aceptar',
        },
        maxDate: new Date(),
        onSelect: function(time){
            var dat = time.getDate()+'/'+(time.getMonth()+1)+"/"+time.getFullYear();
            var elem = document.querySelectorAll('.datepicker1');
            var instance = M.Datepicker.getInstance(elem[0]);
            var dat1 = instance.date;
            if (dat1 > time){
                instance.date = time;
                instance.gotoDate(time);
                document.getElementById('fecha_inicial').value = dat;
            }else{
                instance.gotoDate(dat1);
            }
            instance.options.maxDate = time;
        }
    });
});