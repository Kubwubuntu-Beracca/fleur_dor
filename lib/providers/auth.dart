// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:async'; // gives tools to run code asynchronously and for setting a timer
import 'package:fleur_d_or/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null; //returns a token which is not equal to null
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      //if it is after now then it is valid
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String? email, String? password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyDrWHxFZEO5jyhbCfoelErODv2SVNhfrwk';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      print(responseData);
      print(responseData['expiresIn']);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
      //getting access to the shared_preferences(Storage). We should use await to not store a future but the real access to shared preferences
      final prefs = await SharedPreferences.getInstance();
      //now we can use prefs to write and read data(set for writting(storing) and get for reading(retrieving))
      //if you have more complex data you can always use json.encode({''}) because json is a string

      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate,
      });
      prefs.setString('userData', userData);

      print(json.decode(response.body));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String? email, String? password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> login(String? email, String? password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }

//this method returns a boolean because it would signal we are succeful when we try to automatically log the user in
//we are succeful if we find a token and that token is still valid
  Future<bool> tryAutoLogin() async {
    final prefs = (await SharedPreferences.getInstance());
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    //when expiryDate is before now then it is invalid
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    //time allows us to run some code in the future when the timer expires
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
  //how do i pass the token to the Products Class?use ChangeNotifierProxyProvider
}
