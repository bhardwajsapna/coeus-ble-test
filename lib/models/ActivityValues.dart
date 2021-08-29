class Activity {
  List<DayValues> dayValues;

  Activity({required this.dayValues});

  factory Activity.fromJson(Map<String, dynamic> json) {
    List<DayValues> dayValues = [];
    if (json['dayValues'] != null) {
      json['dayValues'].forEach((v) {
        dayValues.add(new DayValues.fromJson(v));
      });
    }
    return Activity(dayValues: dayValues);
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

  DayValues({
    required this.sampleDate,
    required this.stepsCount,
    required this.sleepHrs,
  });

  factory DayValues.fromJson(Map<String, dynamic> json) {
    return DayValues(
      sampleDate: json['sampleDate'],
      stepsCount: json['stepsCount'],
      sleepHrs: json['sleepHrs'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sampleDate'] = this.sampleDate;
    data['stepsCount'] = this.stepsCount;
    data['sleepHrs'] = this.sleepHrs;
    return data;
  }
}
