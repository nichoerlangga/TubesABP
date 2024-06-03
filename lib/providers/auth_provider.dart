import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _token;

  String? get userId => _userId;
  String? get token => _token;

  Future<void> signUp(String name, String location, String email, String password) async {
    final url = Uri.parse('http://192.168.0.101:8000/api/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'location': location,
          'email': email,
          'password': password,
          'password_confirmation': password, // Ensure this matches
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to register');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://192.168.0.101:8000/api/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      final responseData = json.decode(response.body);
      _token = responseData['token'];
      _userId = responseData['user']['id'];

      // Save token and user ID locally (SharedPreferences or another method)
      // Example:
      // saveTokenLocally(_token);
      // saveUserIdLocally(_userId);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getUserInfo() async {
    final url = Uri.parse('http://192.168.0.101:8000/api/user');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Handle user info response
      } else {
        throw Exception('Failed to get user info');
      }
    } catch (error) {
      throw error;
    }
  }
}
