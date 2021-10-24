import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:coeus_v1/utils/const.dart' as globalAccess;

Future<http.Response> createUserAPIService(requestParams) async {
  print(requestParams);
  print(jsonEncode(requestParams));
  String url_add = globalAccess.Constants.apiurl;
  final response =
      await http.post(Uri.parse('http://$url_add:5000/userRegistration'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestParams));
  print(response.body);
  return response;
}

Future<http.Response> updateProfileAPIService(requestParams) async {
  print(requestParams);

  final response = await http.post(
      Uri.parse('http://192.168.45.49:5000/updateUserProfile?userId=' +
          globalAccess.Constants.userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestParams));
  print(response.body);
  return response;
}

Future<http.Response> updateEmergencyContactAPIService(requestParams) async {
  print(requestParams);
  final response = await http.post(
      Uri.parse('http://192.168.45.49:5000/updateEmergencyContact?userId=' +
          globalAccess.Constants.userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestParams));
  print(response.body);
  return response;
}

Future<http.Response> updateCaregiverDetailsAPIService(requestParams) async {
  print(requestParams);
  final response = await http.post(
      Uri.parse('http://192.168.45.49:5000/updateCaregiverDetails?userId=' +
          globalAccess.Constants.userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestParams));
  print(response.body);
  return response;
}

Future<http.Response> updateAdvancedSettingsAPIService(requestParams) async {
  print(requestParams);

  final response = await http.post(
      Uri.parse(
          'http://192.168.45.49:5000/updateSamplingRateSettings?deviceId=' +
              globalAccess.Constants.deviceId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestParams));
  print(response.body);
  return response;
}
