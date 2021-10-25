//https://github.com/JohannesMilke/secure_storage_example/blob/master/lib/utils/user_secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUserID = 'userid';
  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _keyFirstName = 'firstname';
  static const _keySecondName = 'secondname';
  static const _keyMobileNumber = 'mobilenumber';
  static const _keyDOB = 'dob';
  static const _keyGender = 'gender';
  static const _keyLogOut = 'logout';

  static Future setUserID(String userid) async =>
      await _storage.write(key: _keyUserID, value: userid);

  static Future<String?> getUserID() async =>
      await _storage.read(key: _keyUserID);

  static Future setEmailId(String username) async =>
      await _storage.write(key: _keyUsername, value: username);

  static Future<String?> getEmailId() async =>
      await _storage.read(key: _keyUsername);

  static Future setPassword(String password) async {
    print("inuserseecure password:" + password);
    await _storage.write(key: _keyPassword, value: password);
  }

  static Future<String?> getPassword() async {
    String? temp = await _storage.read(key: _keyPassword);
    print("outuserseecure password:" + temp!);
    return temp;
  }

  static Future setFirstName(String val) async {
    print("inuserseecure firstname:" + val);
    await _storage.write(key: _keyFirstName, value: val);
  }

  static Future<String?> getFirstName() async {
    String? temp = await _storage.read(key: _keyFirstName);
    print("outuserseecure firstname:" + temp!);
    return temp;
  }

  static Future setSecondName(String val) async {
    print("inuserseecure SecondName:" + val);
    await _storage.write(key: _keySecondName, value: val);
  }

  static Future<String?> getSecondName() async {
    String? temp = await _storage.read(key: _keySecondName);
    print("outuserseecure SecondName:" + temp!);
    return temp;
  }

  static Future setMobileNumber(String val) async {
    print("inuserseecure MobileNumber:" + val);
    await _storage.write(key: _keyMobileNumber, value: val);
  }

  static Future<String?> getMobileNumber() async {
    String? temp = await _storage.read(key: _keyMobileNumber);
    print("outuserseecure MobileNumber:" + temp!);
    return temp;
  }

  static Future setDOB(DateTime? val) async {
    final temp = val!.toIso8601String();
    print("inuserseecure DOB:" + temp);
    await _storage.write(key: _keyDOB, value: temp);
  }

  static Future<DateTime?> getDOB() async {
    String? temp = await _storage.read(key: _keyDOB);
    print("outuserseecure DOB:" + temp!);
    if (temp == null) {
      return null;
    } else {
      return DateTime.tryParse(temp);
    }
  }

  static Future setGender(String val) async {
    print("inuserseecure Gender:" + val);
    await _storage.write(key: _keyGender, value: val);
  }

  static Future<String?> getGender() async {
    String? temp = await _storage.read(key: _keyGender);
    print("outuserseecure Gender:" + temp!);
    return temp;
  }

  static Future logOut() async {
    await _storage.deleteAll();
  }
}
