/*class MonthReadingOnceADay {
  List<DayValues> dayValues;

  MonthReadingOnceADay({this.dayValues});

  MonthReadingOnceADay.fromJson(Map<String, dynamic> json) {
    if (json['dayValues'] != null) {
      dayValues = new List<DayValues>();
      json['dayValues'].forEach((v) {
        dayValues.add(new DayValues.fromJson(v));
      });
    }
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

  DayValues({this.sampleDate, this.stepsCount, this.sleepHrs});

  DayValues.fromJson(Map<String, dynamic> json) {
    sampleDate = json['sampleDate'];
    stepsCount = json['stepsCount'];
    sleepHrs = json['sleepHrs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sampleDate'] = this.sampleDate;
    data['stepsCount'] = this.stepsCount;
    data['sleepHrs'] = this.sleepHrs;
    return data;
  }
}
*/