import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/category/categoryPage.dart';
import 'package:shop_app/screens/sign_in/components/sign_form.dart';
import 'package:shop_app/services/auth_service.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'package:shop_app/screens/chat/chatPage.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/register_success_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/account_detail_screen.dart';
import 'package:shop_app/screens/input_product/inputPage.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder>  routes = {
  SignInScreen.routeName: (context) => SignInPage(),
  SignUpScreen.routeName: (context) => SignUpScreen(authService: AuthService()),
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  RegisterSuccessScreen.routeName: (context) => const RegisterSuccessScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AccountDetailsScreen.routeName: (context) => AccountDetailsScreen(),
  InputProductPage.routeName: (context) => const InputProductPage(),
  // FavoriteScreen.routeName: (context) {
  //   final authService = AuthService(); // Initialize AuthService here
  //   final userId = authService.userData?['id'];
  //   return FavoriteScreen(userId: userId);
  // },
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  ChatPage.routeName: (context) => const ChatPage(),
  CategoryScreen.routeName: (context) => CategoryScreen(categoryId:ModalRoute.of(context)!.settings.arguments as int),
};
