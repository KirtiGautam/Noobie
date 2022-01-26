import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/env.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? _userID;
  Timer? _authTimer;

  String? get token =>
      (_token != null && _expiry != null && _expiry!.isAfter(DateTime.now()))
          ? _token
          : null;

  String? get userID => _userID;
  bool get isAuthenticated => token != null;

  Future<void> _authenticate(String email, String password, String action) {
    final uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$action?key=$API_KEY');
    return http
        .post(
      uri,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    )
        .then((value) {
      final data = json.decode(value.body);
      _token = data['idToken'];
      _userID = data['localId'];
      _expiry = DateTime.now().add(
        Duration(
          seconds: int.parse(data['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final userData = json.encode({
        'token': _token,
        'userID': _userID,
        'expiryDate': _expiry!.toIso8601String(),
      });
      SharedPreferences.getInstance().then((val) {
        val.setString('userData', userData);
      });
    });
  }

  Future<void> signup(
    String email,
    String password,
  ) =>
      _authenticate(
        email,
        password,
        'signUp',
      );
  Future<void> login(
    String email,
    String password,
  ) =>
      _authenticate(
        email,
        password,
        'signInWithPassword',
      );

  Future<bool> tryAutoLogin() {
    return SharedPreferences.getInstance().then((value) {
      if (!value.containsKey('userData')) {
        return false;
      }
      final extractedUserData =
          json.decode(value.getString('userData')!) as Map<String, dynamic>;
      final expiryDate = DateTime.parse(extractedUserData['expiryDate']!);
      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }
      _token = extractedUserData['token'];
      _userID = extractedUserData['userID'];
      _expiry = expiryDate;
      notifyListeners();
      _autoLogout();
      return true;
    });
  }

  void logout() {
    _userID = null;
    _token = null;
    _expiry = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    SharedPreferences.getInstance().then((value) => value.clear());
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiry!.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpiry), logout);
  }
}
