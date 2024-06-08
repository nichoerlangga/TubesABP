import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../screens/input_product/inputPage.dart';
import '../../screens/chat/chatPage.dart';
import '../../screens/favorite/favorite_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

class ProfilePic extends StatefulWidget {
  final String name;

  const ProfilePic({
    super.key,
    required this.name,
  });

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundImage: _image == null
                    ? AssetImage("assets/images/Profile Image.png")
                    : FileImage(_image!) as ImageProvider,
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: _pickImage,
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
  });

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(), // Remove the back button
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: kPrimaryColor), // Replace kPrimaryColor with your desired color
        ),
        centerTitle: true, // Align the title to the center
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(name: "Muhammad Asep"), // Pass the name to ProfilePic
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.pushNamed(context, AccountDetailsScreen.routeName)
              },
            ),
            ProfileMenu(
              text: "Wishlist",
              icon: "assets/icons/Heart Icon.svg",
              press: () {
                Navigator.pushNamed(context, FavoriteScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Input Product",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.pushNamed(context, InputProductPage.routeName);
              },
            ),
            ProfileMenu(
              text: "Chat",
              icon: "assets/icons/Chat bubble Icon.svg",
              press: () {
                Navigator.pushNamed(context, ChatPage.routeName);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}