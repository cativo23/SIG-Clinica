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
        setDefaultDate : true,
        defaultDate: new Date(),
        onSelect: function(time){
            console.log(time);
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
        setDefaultDate : true,
        defaultDate: new Date(),
        onSelect: function(time){
            var elem = document.querySelectorAll('.datepicker1');
            var instance = M.Datepicker.getInstance(elem[0]);
             instance.setDate(time);
             instance.gotoDate(time);
             instance.defaultDate = time;
             instance.options.maxDate = time;
             instance.options.defaultDate = time;
             instance.date = time;
            console.log("hola");
            console.log(instance);
        }
    });
});