class SpO2 {
  List<Spo2Values> spO2Values;

  SpO2({required this.spO2Values});

  factory SpO2.fromJson(Map<String, dynamic> json) {
    List<Spo2Values> spO2Values = [];
    if (json['spo2Values'] != null) {
      json['spo2Values'].forEach((v) {
        spO2Values.add(new Spo2Values.fromJson(v));
      });
    }
    return SpO2(spO2Values: spO2Values);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.spO2Values != null) {
      data['spo2Values'] = this.spO2Values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Spo2Values {
  String sampleDate;
  List<Samples> samples;

  Spo2Values({required this.sampleDate, required this.samples});

  factory Spo2Values.fromJson(Map<String, dynamic> json) {
    List<Samples> listSamples = [];
    json['samples'].forEach((v) {
      listSamples.add(new Samples.fromJson(v));
    });
    return Spo2Values(sampleDate: json['sampleDate'], samples: listSamples);
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
  int spo2;

  Samples({required this.time, required this.spo2});

  factory Samples.fromJson(Map<String, dynamic> json) =>
      Samples(time: json['time'], spo2: json['spo2']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['spo2'] = this.spo2;
    return data;
  }
}
