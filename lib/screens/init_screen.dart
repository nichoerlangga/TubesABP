// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/screens/chat/chatPage.dart';
// import 'package:shop_app/screens/favorite/favorite_screen.dart';
// import 'package:shop_app/screens/home/home_screen.dart';
// import 'package:shop_app/screens/input_product/inputPage.dart';
// import 'package:shop_app/screens/profile/profile_screen.dart';
//
// const Color inActiveIconColor = Color(0xFFB6B6B6);
//
// class InitScreen extends StatefulWidget {
//   const InitScreen({super.key});
//
//   static String routeName = "/";
//
//   @override
//   State<InitScreen> createState() => _InitScreenState();
// }
//
// class _InitScreenState extends State<InitScreen> {
//   int currentSelectedIndex = 0;
//
//   void updateCurrentIndex(int index) {
//     setState(() {
//       currentSelectedIndex = index;
//     });
//   }
//
//   final pages = [
//     const HomeScreen(),
//     FavoriteScreen(),
//     const InputProductPage(),
//     const ChatPage(),
//     ProfileScreen()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[currentSelectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: updateCurrentIndex,
//         currentIndex: currentSelectedIndex,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/Shop Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 inActiveIconColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/icons/Shop Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 kPrimaryColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/Heart Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 inActiveIconColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/icons/Heart Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 kPrimaryColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Fav",
//           ),BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/plus.svg",
//               colorFilter: const ColorFilter.mode(
//                 inActiveIconColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/icons/plus.svg",
//               colorFilter: const ColorFilter.mode(
//                 kPrimaryColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Fav",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/Chat bubble Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 inActiveIconColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/icons/Chat bubble Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 kPrimaryColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Chat",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/User Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 inActiveIconColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/icons/User Icon.svg",
//               colorFilter: const ColorFilter.mode(
//                 kPrimaryColor,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: "Fav",
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/chat/chatPage.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/input_product/inputPage.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import '../../services/auth_service.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;
  final AuthService _authService = Get.find<AuthService>();

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userId = _authService.userData['id']; // Reactive user data

      if (userId == null) {
        return Center(child: CircularProgressIndicator()); // Show loading indicator if user data is not available
      }

      final pages = [
        const HomeScreen(),
        // FavoriteScreen(userId: userId),
        FavoriteScreen(),
        const InputProductPage(),
        const ChatPage(),
        ProfileScreen(),
      ];

      return Scaffold(
        body: pages[currentSelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: updateCurrentIndex,
          currentIndex: currentSelectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Heart Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Heart Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Fav",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/plus.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/plus.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}




