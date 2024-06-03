import 'package:flutter/material.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import 'account_detail_screen.dart';
import 'package:shop_app/constants.dart';
import '../../screens/input_product/inputPage.dart';
import '../../screens/chat/chatPage.dart';
import '../../screens/favorite/favorite_screen.dart';

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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kPrimaryColor), // Replace kPrimaryColor with your desired color
        ),
        centerTitle: true, // Align the title to the center
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
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
              icon: "assets/icons/Heart icon.svg",
              press: () {
                Navigator.pushNamed(context, FavoriteScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Input Product",
              icon: "assets/icons/Plus.svg",
              press: () {
                Navigator.pushNamed(context, InputProductPage.routeName);
              },
            ),
            ProfileMenu(
              text: "Chat",
              icon: "assets/icons/Chat bubble icon.svg",
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
