// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:fleur_d_or/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

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
      notifyListeners();
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

  //how do i pass the token to the Products Class?use ChangeNotifierProxyProvider
}
