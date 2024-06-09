import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountDetailsScreen extends StatelessWidget {
  static String routeName = "/account_details";
  final AuthService _authService = Get.put(AuthService());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  AccountDetailsScreen({Key? key}) : super(key: key);

  Future<void> updateUser() async {
    final userData = _authService.userData;
    final userId = userData["id"];

    final url = Uri.parse('http://192.168.0.104:8000/api/user/$userId');

    final requestBody = {
      'name': _nameController.text,
      'email': _emailController.text,
      'location': _locationController.text,
    };

    // Only add password to the request body if it is not empty
    if (_passwordController.text.isNotEmpty) {
      requestBody['password'] = _passwordController.text;
    }

    print('Request URL: $url');
    print('Request Body: $requestBody');

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final updatedUser = jsonDecode(response.body)["data"];
      _authService.userData.value = updatedUser;
      Get.snackbar('Success', 'Profile updated successfully');
    } else {
      final error = jsonDecode(response.body);
      Get.snackbar('Error', 'Failed to update profile: ${error['message']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              final userData = _authService.userData;
              _nameController.text = userData["name"] ?? "";
              _emailController.text = userData["email"] ?? "";
              _locationController.text = userData["location"] ?? "";

              return Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter your name",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: "Location",
                      hintText: "Enter your location",
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateUser();
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}