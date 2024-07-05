import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_online/models/auth/login_model.dart';
import 'package:shop_online/models/auth/signup_model.dart';
import 'package:shop_online/services/authhelper.dart';

class LoginNotifier extends ChangeNotifier {
  bool _isObsecure = false;
  bool get isObsecure => _isObsecure;
  set isObsecure(bool newState) {
    _isObsecure = newState;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newState) {
    _processing = newState;
    notifyListeners();
  }

  bool _loginResponseBool = false;
  bool get loginResponseBool => _loginResponseBool;
  set loginResponseBool(bool newState) {
    _loginResponseBool = newState;
    notifyListeners();
  }

  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool newState) {
    _responseBool = newState;
    notifyListeners();
  }

  bool? _loggeIn;
  bool get loggeIn => _loggeIn ?? false;
  set loggeIn(bool newState) {
    _loggeIn = newState;
    notifyListeners();
  }

  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggeIn = prefs.getBool('isLogged') ?? false;
    notifyListeners();
  }

  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    processing = true;
    bool response = await AuthHelper().login(model);
    processing = false;

    loginResponseBool = response;

    prefs.setBool('isLogged', response); // Store login state

    loggeIn = response;
    notifyListeners();

    return loginResponseBool;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
    prefs.remove('userId');
    prefs.setBool('isLogged', false); // Update login state to false
    loggeIn = false;
    notifyListeners();
  }

  Future<bool> registerUser(SignupModel model) async {
    responseBool = await AuthHelper().signup(model);
    return responseBool;
  }
}
