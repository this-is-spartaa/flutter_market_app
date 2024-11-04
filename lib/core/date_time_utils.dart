import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatString(DateTime datetime) {
    final now = DateTime.now();
    final diff = now.difference(datetime);

    if (diff.inMinutes < 60) {
      // 1시간 이내
      return '${diff.inMinutes} 분 전';
    } else if (diff.inHours < 24) {
      // 24시간보다 작을 때
      return '${diff.inHours} 시간 전';
    } else {
      // 하루 초과
      return DateFormat('M월 d일').format(datetime);
    }
  }
}
