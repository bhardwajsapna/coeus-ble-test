import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static StorageUtil? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageUtil?> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageUtil._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  static Future<bool?> setUserName(String value) async {
    if (_preferences == null) return null;
    return _preferences!.setString('username', value);
  }

  static String getUserName({String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences!.getString('username') ?? defValue;
  }

  static Future<bool?> setPassword(String value) async {
    if (_preferences == null) return null;
    return _preferences!.setString('password', value);
  }

  static String getPassword({String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences!.getString('password') ?? defValue;
  }

  static Future<bool> clear() async {
    if (_preferences == null)
      return false;
    else {
      _preferences!.remove('username');
      _preferences!.remove('password');
      return true;
    }
  }
}
