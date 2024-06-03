import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://172.20.10.5:8000/api';

  Future<void> login(String email, String password) async {
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
      print('Login successful: ${data['user']}');
    } else {
      var errorData = jsonDecode(response.body);
      throw Exception('Failed to login: ${errorData['error']}');
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
        'password_confirmation': password,  // Add password confirmation
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

  // New method to test the API connection
  Future<void> testConnection() async {
    final response = await http.get(Uri.parse('$baseUrl/test'));

    if (response.statusCode == 200) {
      print('API is working: ${response.body}');
    } else {
      throw Exception('Failed to connect to API');
    }
  }
}
