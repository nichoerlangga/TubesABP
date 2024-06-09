import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/services/auth_service.dart';

class AccountDetailsScreen extends StatelessWidget {
  static String routeName = "/account_details";
  final AuthService _authService = Get.put(AuthService());

  AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final userData = _authService.userData;
          final String? username = userData["name"];
          final String? email = userData["email"];
          final String? location = userData["location"];

          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: username ?? "Enter your name",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: email ?? "Enter your email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Location",
                  hintText: location ?? "Enter your location",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle save action
                },
                child: const Text("Save"),
              ),
            ],
          );
        }),
      ),
    );
  }
}
