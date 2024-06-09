import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends GetxController {
  final String baseUrl = 'http://192.168.0.104:8000/api';
  var userData = {}.obs;
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userData.value = data['user'];
        debugPrint("User data after login: $userData");
        print('Login successful: ${data['user']}');
      } else {
        var errorData = jsonDecode(response.body);
        throw Exception('Failed to login: ${errorData['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password, String location) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'location': location,
        'password_confirmation': password,
      }),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print('Registration successful: ${data['user']}');
    } else {
      var errorData = jsonDecode(response.body);
      throw Exception('Failed to register: ${errorData['errors']}');
    }
  }

  Future<void> testConnection() async {
    final response = await http.get(Uri.parse('$baseUrl/test'));

    if (response.statusCode == 200) {
      print('API is working: ${response.body}');
    } else {
      throw Exception('Failed to connect to API');
    }
  }
}
