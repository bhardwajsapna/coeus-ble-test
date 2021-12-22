// To parse this JSON data, do
//
//     final bioValues = bioValuesFromJson(jsonString);

import 'dart:convert';

BioValues bioValuesFromJson(String str) => BioValues.fromJson(json.decode(str));

String bioValuesToJson(BioValues data) => json.encode(data.toJson());

class BioValues {
  BioValues({
    this.userId,
    this.deviceId,
    this.duration,
    this.medicalValues,
    this.startTime,
    this.samplingInfo,
  });

  String? userId;
  String? deviceId;
  int? duration;
  Map<String, List<int>>? medicalValues;
  String? startTime;
  Map<String, int>? samplingInfo;

/*
22 aug 21
below function has to be updated for reading the new json file format
*/
  factory BioValues.fromJson(Map<String, dynamic> json) => BioValues(
        userId: json["user_id"],
        deviceId: json["device_id"],
        duration: json["duration"],
        medicalValues: Map.from(json["medical_values"]).map((k, v) =>
            MapEntry<String, List<int>>(k, List<int>.from(v.map((x) => x)))),
        startTime: json["start_time"],
        samplingInfo: Map.from(json["sampling_info"])
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "device_id": deviceId,
        "duration": duration,
        "medical_values": Map.from(medicalValues!).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "start_time": startTime,
        "sampling_info": Map.from(samplingInfo!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
