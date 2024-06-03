// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/providers/auth_provider.dart';
// import 'package:shop_app/screens/home/home_screen.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
// import 'package:shop_app/screens/splash/splash_screen.dart';
//
// import 'routes.dart';
// import 'theme.dart';
//
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, authProvider, _) {
//         // Check if the user is authenticated
//         if (authProvider.isAuthenticated) {
//           // If authenticated, navigate to the HomeScreen
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'The Flutter Way - Template',
//             theme: AppTheme.lightTheme(context),
//             initialRoute: HomeScreen.routeName,
//             routes: routes,
//           );
//         } else {
//           // If not authenticated, navigate to the SignInScreen
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'The Flutter Way - Template',
//             theme: AppTheme.lightTheme(context),
//             initialRoute: SignInScreen.routeName,
//             routes: routes,
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
