import 'dart:convert';

MonthReadingOnceADay convertJsonToMonthReadingOnceADay(String str) =>
    MonthReadingOnceADay.fromJson(json.decode(str));

class MonthReadingOnceADay {
  List<DayValues> dayValues;

  MonthReadingOnceADay({required this.dayValues});

  factory MonthReadingOnceADay.fromJson(Map<String, dynamic> json) {
    List<DayValues> dayValues = [];
    json['dayValues'].forEach((v) {
      dayValues.add(new DayValues.fromJson(v));
    });
    return MonthReadingOnceADay(dayValues: dayValues);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dayValues != null) {
      data['dayValues'] = this.dayValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayValues {
  String sampleDate;
  int stepsCount;
  String sleepHrs;

  DayValues(
      {required this.sampleDate,
      required this.stepsCount,
      required this.sleepHrs});

  factory DayValues.fromJson(Map<String, dynamic> json) => DayValues(
      sampleDate: json['sampleDate'],
      stepsCount: json['stepsCount'],
      sleepHrs: json['sleepHrs']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sampleDate'] = this.sampleDate;
    data['stepsCount'] = this.stepsCount;
    data['sleepHrs'] = this.sleepHrs;
    return data;
  }
}
