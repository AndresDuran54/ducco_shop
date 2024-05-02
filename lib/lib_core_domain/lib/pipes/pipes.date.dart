import 'package:intl/intl.dart';

class PipesDate {
  static String epochToDateFormat(int epoch, int offsetHours,
      {String format = 'dd MMM yyyy • hh:mm'}) {
    //+ Transformamos el epoch en un DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch, isUtc: true);

    //+ Definimos el desplazamiento horario (por ejemplo, UTC+3)
    Duration offset = Duration(hours: offsetHours);

    //+ Agregamos el desplazamiento horario
    dateTime = dateTime.add(offset);

    //+ Convertimos el DateTime a una cadena con formato deseado
    return DateFormat(format).format(dateTime);
  }
}
