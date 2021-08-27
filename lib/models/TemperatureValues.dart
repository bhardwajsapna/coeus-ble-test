class TemperatureValues {
  List<TempValues> tempValues;

  TemperatureValues({required this.tempValues});

  factory TemperatureValues.fromJson(Map<String, dynamic> json) {
    List<TempValues> tempValues = [];
    if (json['tempValues'] != null) {
      json['tempValues'].forEach((v) {
        tempValues.add(new TempValues.fromJson(v));
      });
    }
    return TemperatureValues(tempValues: tempValues);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tempValues != null) {
      data['tempValues'] = this.tempValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TempValues {
  String sampleDate;
  List<Samples> samples;

  TempValues({required this.sampleDate, required this.samples});

  factory TempValues.fromJson(Map<String, dynamic> json) {
    List<Samples> listSamples = [];
    json['samples'].forEach((v) {
      listSamples.add(new Samples.fromJson(v));
    });
    return TempValues(sampleDate: json['sampleDate'], samples: listSamples);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sampleDate'] = this.sampleDate;
    if (this.samples != null) {
      data['samples'] = this.samples.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Samples {
  String time;
  int temp;

  Samples({required this.time, required this.temp});

  factory Samples.fromJson(Map<String, dynamic> json) =>
      Samples(time: json['time'], temp: json['temp']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temp'] = this.temp;
    return data;
  }
}
