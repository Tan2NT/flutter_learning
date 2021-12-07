import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class Auth with ChangeNotifier {
  String _token = '';
  DateTime? _expiredDate = null;
  String _userId = '';
  Timer? _authTimer = null;

  final String _apiKey = 'AIzaSyC-jEsZDUolsU-I8fBmhoPOAKnCurCwNUE';
  final String _baseURL = 'https://identitytoolkit.googleapis.com/v1/accounts';

  bool get isAuth {
    return token.isNotEmpty;
  }

  String get token {
    if (_expiredDate == null) return '';
    if (_expiredDate!.isAfter(DateTime.now()) && _token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(
      String email, String password, AuthMode authMode) async {
    final authType =
        authMode == AuthMode.Signup ? 'signUp' : 'signInWithPassword';
    final url = Uri.parse('$_baseURL:$authType?key=$_apiKey');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiredDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, AuthMode.Signup);
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, AuthMode.Login);
  }

  void logout() {
    _token = '';
    _userId = '';
    _expiredDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_expiredDate == null) return;
    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpiry = _expiredDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
