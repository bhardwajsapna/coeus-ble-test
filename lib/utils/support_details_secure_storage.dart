//https://github.com/JohannesMilke/secure_storage_example/blob/master/lib/utils/user_secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SupportDetailsSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyEmergencyFirstName = 'emergencyfirstname';
  static const _keyEmergencySecondName = 'emergencysecondname';
  static const _keyEmergencyMobileNumber = 'emergencymobilenumber';
  static const _keyEmergencyEmailId = 'emergencyemailid';

  static const _keyCaretakerFirstName = 'caretakerfirstname';
  static const _keyCaretakerSecondName = 'caretakersecondname';
  static const _keyCaretakerMobileNumber = 'caretakermobilenumber';
  static const _keyCaretakerEmailId = 'caretakeremailid';

  static Future setEmergencyFirstName(String val) async {
    print("inuserseecure Emergencyfirstname:" + val);
    await _storage.write(key: _keyEmergencyFirstName, value: val);
  }

  static Future<String?> getEmergencyFirstName() async {
    String? temp = await _storage.read(key: _keyEmergencyFirstName);
    print("outuserseecure Emergencyfirstname:" + temp!);
    return temp;
  }

  static Future setCaretakerFirstName(String val) async {
    print("inuserseecure Caretakerfirstname:" + val);
    await _storage.write(key: _keyCaretakerFirstName, value: val);
  }

  static Future<String?> getCaretakerFirstName() async {
    String? temp = await _storage.read(key: _keyCaretakerFirstName);
    print("outuserseecure Caretakerfirstname:" + temp!);
    return temp;
  }

  static Future setEmergencySecondName(String val) async {
    print("inuserseecure EmergencySecondName:" + val);
    await _storage.write(key: _keyEmergencySecondName, value: val);
  }

  static Future<String?> getEmergencySecondName() async {
    String? temp = await _storage.read(key: _keyEmergencySecondName);
    print("outuserseecure EmergencySecondName:" + temp!);
    return temp;
  }

  static Future setCaretakerSecondName(String val) async {
    print("inuserseecure CaretakerSecondName:" + val);
    await _storage.write(key: _keyCaretakerSecondName, value: val);
  }

  static Future<String?> getCaretakerSecondName() async {
    String? temp = await _storage.read(key: _keyCaretakerSecondName);
    print("outuserseecure CaretakerSecondName:" + temp!);
    return temp;
  }

  static Future setEmergencyMobileNumber(String val) async {
    print("inuserseecure EmergencyMobileNumber:" + val);
    await _storage.write(key: _keyEmergencyMobileNumber, value: val);
  }

  static Future<String?> getEmergencyMobileNumber() async {
    String? temp = await _storage.read(key: _keyEmergencyMobileNumber);
    print("outuserseecure EmergencyMobileNumber:" + temp!);
    return temp;
  }

  static Future setCaretakerMobileNumber(String val) async {
    print("inuserseecure CaretakerMobileNumber:" + val);
    await _storage.write(key: _keyCaretakerMobileNumber, value: val);
  }

  static Future<String?> getCaretakerMobileNumber() async {
    String? temp = await _storage.read(key: _keyCaretakerMobileNumber);
    print("outuserseecure CaretakerMobileNumber:" + temp!);
    return temp;
  }

  static Future setEmergencyEmailId(String val) async =>
      await _storage.write(key: _keyEmergencyEmailId, value: val);

  static Future<String?> getEmergencyEmailId() async =>
      await _storage.read(key: _keyEmergencyEmailId);

  static Future setCaretakerEmailId(String val) async =>
      await _storage.write(key: _keyCaretakerEmailId, value: val);

  static Future<String?> getCaretakerEmailId() async =>
      await _storage.read(key: _keyCaretakerEmailId);
}
