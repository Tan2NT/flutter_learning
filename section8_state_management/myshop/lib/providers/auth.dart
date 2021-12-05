import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiredDate = DateTime.now();
  String _userId = '';

  final String _apiKey = 'AIzaSyC-jEsZDUolsU-I8fBmhoPOAKnCurCwNUE';
  final String _baseURL = 'https://identitytoolkit.googleapis.com/v1/accounts';

  bool get isAuth {
    return token != null && token != '';
  }

  String? get token {
    if (_expiredDate != null &&
        _expiredDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
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
}
