import 'package:flutter/material.dart';

extension DateTimeHelpers on DateTime {
  String getDateString() {
    return "${"$day".padLeft(2, '0')}/${"$month".padLeft(2, '0')}/${"$year".padLeft(4, '0')}";
  }

  String getDateStringWithMonthName() {
    Map<int, String> monthNames = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December"
    };
    return "${"$day".padLeft(2, '0')} ${monthNames[month]} $year";
  }

  String getDateStringWithShortMonthName() {
    Map<int, String> monthNames = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec"
    };
    return "${"$day".padLeft(2, '0')} ${monthNames[month]} $year";
  }

  String getYear() {
    return "$year";
  }

  String get getMonthName {
    Map<int, String> monthNames = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    return monthNames[month]!;
  }

  String get getMonthFullName {
    Map<int, String> monthNames = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    };
    return monthNames[month]!;
  }

  String getHowMuchTimeAgo() {
    Duration difference = DateTime.now().difference(this);
    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }

  String get getHowMuchTimeRemaining {
    Duration difference = this.difference(DateTime.now());
    if (difference.inDays > 0) {
      return "${difference.inDays} days remaining";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours remaining";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes remaining";
    } else {
      return "Started";
    }
  }

  String get getTimeInAmPm {
    String hour =
        this.hour == 12 ? "12" : (this.hour % 12).toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String amPm = this.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $amPm';
  }
}

extension TimeOfDayHelpers on TimeOfDay {
  String get getTimeInAmPm {
    String hour =
        this.hour == 12 ? "12" : (this.hour % 12).toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String amPm = this.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $amPm';
  }
}

extension DurationHelpers on Duration {
  String get getDurationInAmPm {
    String hour = (inHours).toString().padLeft(2, '0');
    String minute = (inMinutes % 60).toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get getHowMuchTimeRemaining {
    if (inDays > 0) {
      return "$inDays days remaining";
    } else if (inHours > 0) {
      return "$inHours hours remaining";
    } else if (inMinutes > 0) {
      return "$inMinutes minutes remaining";
    } else {
      return "Just now";
    }
  }
}

extension TimeOfDayStringHelpers on String {
  TimeOfDay get getTimeOfDayFromAmPm {
    List<String> time = split(" ");
    List<String> hourMinute = time[0].split(":");
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    if (time[1] == "PM") {
      hour += 12;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }
}
