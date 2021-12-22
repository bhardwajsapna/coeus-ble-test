class BPM {
  List<BPMValues> bpmValues;

  BPM({required this.bpmValues});

  factory BPM.fromJson(Map<String, dynamic> json) {
    List<BPMValues> bpmValues = [];
    if (json['bpmValues'] != null) {
      json['bpmValues'].forEach((v) {
        bpmValues.add(new BPMValues.fromJson(v));
      });
    }
    return BPM(bpmValues: bpmValues);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bpmValues != null) {
      data['bpmValues'] = this.bpmValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BPMValues {
  String sampleDate;
  List<Samples> samples;

  BPMValues({required this.sampleDate, required this.samples});

  factory BPMValues.fromJson(Map<String, dynamic> json) {
    List<Samples> listSamples = [];
    json['samples'].forEach((v) {
      listSamples.add(new Samples.fromJson(v));
    });
    return BPMValues(sampleDate: json['sampleDate'], samples: listSamples);
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
  int bpm;

  Samples({required this.time, required this.bpm});

  factory Samples.fromJson(Map<String, dynamic> json) =>
      Samples(time: json['time'], bpm: json['bpm']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['bpm'] = this.bpm;
    return data;
  }
}
