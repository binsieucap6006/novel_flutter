// ignore_for_file: file_names

class TimeLeft {
  String timeLeft(DateTime due) {
    String retVal;

    Duration timeUntilDue = due.difference(DateTime.now());

    int daysUntil = timeUntilDue.inDays;
    int hoursUntil = timeUntilDue.inHours - (daysUntil * 24);
    int minUntil =
        timeUntilDue.inMinutes - (daysUntil * 24 * 60) - (hoursUntil * 60);

    if (daysUntil > 0) {
      retVal = "$daysUntil days\n$hoursUntil hours\n$minUntil mins";
    } else if (hoursUntil > 0) {
      retVal = "$hoursUntil hours\n$minUntil mins";
    } else if (minUntil > 0) {
      retVal = "$minUntil mins";
    } else if (minUntil == 0) {
      retVal = "almost there ";
    } else {
      retVal = "error";
    }

    return retVal;
  }
}
