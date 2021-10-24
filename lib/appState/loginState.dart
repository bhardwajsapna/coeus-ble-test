import 'package:coeus_v1/utils/storageUtils.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';

enum AppState { LOGIN_INITIAL, LOGIN_SUCCESS, LOGIN_FAILURE }

class LoginStateProvider extends ChangeNotifier {
  AppState _appState = AppState.LOGIN_INITIAL;

  LoginStateProvider() {
    checkAutoLogin();
  }

  Future checkAutoLogin() async {
    try {
      String? userName = await UserSecureStorage.getEmailId();

      String? passWord = await UserSecureStorage.getPassword();
      await userLogin(userName!, passWord!);
      print('>>>>>>>>>' + userName);
    } catch (e) {
      _appState = AppState.LOGIN_FAILURE;
      notifyListeners();
    }
  }

  Future userLogin(String userName, String password) async {
    try {
      await StorageUtil.setUserName(userName);
      await StorageUtil.setPassword(password);
      _appState = AppState.LOGIN_SUCCESS;
      notifyListeners();
    } catch (e) {
      _appState = AppState.LOGIN_FAILURE;
      notifyListeners();
    }
  }

  Future userLogout() async {
    print("deleteing user...");
    await StorageUtil.clear();
    _appState = AppState.LOGIN_SUCCESS;
    notifyListeners();
  }

  AppState get appState => _appState;
}
