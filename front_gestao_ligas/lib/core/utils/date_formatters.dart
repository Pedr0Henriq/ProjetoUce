import 'package:intl/intl.dart';

/// Formatadores de data e hora
class DateFormatters {
  DateFormatters._();

  static final _dateFmt = DateFormat('dd/MM/yyyy');
  static final _dateTimeFmt = DateFormat('dd/MM/yyyy HH:mm');
  //static final _timeFmt = DateFormat('HH:mm');

  static String data(DateTime? date) {
    if (date == null) return 'A definir';
    return _dateFmt.format(date);
  }

  static String dataHora(DateTime? date) {
    if (date == null) return 'A definir';
    return _dateTimeFmt.format(date);
  }

  static String hora(String? horario) {
    return horario ?? 'A definir';
  }
}
