import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatelessWidget {
  static String routeName = "/account_details";

  const AccountDetailsScreen({super.key});

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
            TextField(
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter your name",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
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
              decoration: const InputDecoration(
                labelText: "Location",
                hintText: "Enter your location",
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
        ),
      ),
    );
  }
}
