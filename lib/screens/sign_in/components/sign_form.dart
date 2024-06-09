import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/services/auth_service.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';
import '/components/custom_surfix_icon.dart';
import '/components/form_error.dart';
import '/components/no_account_text.dart';
import '/components/socal_card.dart';
import '/constants.dart';
import '/helper/keyboard.dart';


class SignInPage extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
  final AuthService _authService = Get.put(AuthService());

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      try {
        await _authService.login(email!, password!);
        Get.toNamed(LoginSuccessScreen.routeName);
      } catch (e) {
        // Handle login error here
        Get.snackbar('Login Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => email = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kEmailNullError);
                            } else if (emailValidatorRegExp.hasMatch(value)) {
                              removeError(error: kInvalidEmailError);
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kEmailNullError);
                              return "";
                            } else if (!emailValidatorRegExp.hasMatch(value)) {
                              addError(error: kInvalidEmailError);
                              return "";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => password = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError);
                            } else if (value.length >= 8) {
                              removeError(error: kShortPassError);
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kPassNullError);
                              return "";
                            } else if (value.length < 8) {
                              addError(error: kShortPassError);
                              return "";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: remember,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                setState(() {
                                  remember = value;
                                });
                              },
                            ),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, ForgotPasswordScreen.routeName),
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        FormError(errors: errors),
                        const SizedBox(height: 16),
                        Obx(() {
                          return _authService.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: _login,
                            child: const Text("Continue"),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shop_app/services/auth_service.dart';
// import '/components/custom_surfix_icon.dart';
// import '/components/form_error.dart';
// import '/constants.dart';
// import '/helper/keyboard.dart';
// import '/screens/forgot_password/forgot_password_screen.dart';
// import '/screens/login_success/login_success_screen.dart';
//
// class SignForm extends StatefulWidget {
//   final AuthService authService;
//
//   const SignForm({Key? key, required this.authService}) : super(key: key);
//
//   @override
//   _SignFormState createState() => _SignFormState();
// }
//
// class _SignFormState extends State<SignForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   bool? remember = false;
//   final List<String?> errors = [];
//
//   void addError({String? error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }
//
//   void removeError({String? error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }
//
//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         await widget.authService.login(email!, password!);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginSuccessScreen()),
//         );
//       } catch (e) {
//         addError(error: e.toString());
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             onSaved: (newValue) => email = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kEmailNullError);
//               } else if (emailValidatorRegExp.hasMatch(value)) {
//                 removeError(error: kInvalidEmailError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kEmailNullError);
//                 return "";
//               } else if (!emailValidatorRegExp.hasMatch(value)) {
//                 addError(error: kInvalidEmailError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Email",
//               hintText: "Enter your email",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             obscureText: true,
//             onSaved: (newValue) => password = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kPassNullError);
//               } else if (value.length >= 8) {
//                 removeError(error: kShortPassError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kPassNullError);
//                 return "";
//               } else if (value.length < 8) {
//                 addError(error: kShortPassError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Password",
//               hintText: "Enter your password",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Checkbox(
//                 value: remember,
//                 activeColor: kPrimaryColor,
//                 onChanged: (value) {
//                   setState(() {
//                     remember = value;
//                   });
//                 },
//               ),
//               const Text("Remember me"),
//               const Spacer(),
//               GestureDetector(
//                 onTap: () => Navigator.pushNamed(
//                     context, ForgotPasswordScreen.routeName),
//                 child: const Text(
//                   "Forgot Password",
//                   style: TextStyle(decoration: TextDecoration.underline),
//                 ),
//               )
//             ],
//           ),
//           FormError(errors: errors),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _login,
//             child: const Text("Continue"),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //
//
// import 'package:flutter/material.dart';
// import '/components/custom_surfix_icon.dart';
// import '/components/form_error.dart';
// import '/constants.dart';
// import '/helper/keyboard.dart';
// import '/screens/forgot_password/forgot_password_screen.dart';
// import '/screens/login_success/login_success_screen.dart';
// import '/services/auth_service.dart';
//
// class SignForm extends StatefulWidget {
//   final AuthService authService;
//
//   const SignForm({Key? key, required this.authService}) : super(key: key);
//
//   @override
//   _SignFormState createState() => _SignFormState();
// }
//
// class _SignFormState extends State<SignForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   bool? remember = false;
//   final List<String?> errors = [];
//
//   AuthService get _authService => widget.authService;
//
//   void addError({String? error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }
//
//   void removeError({String? error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             onSaved: (newValue) => email = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kEmailNullError);
//               } else if (emailValidatorRegExp.hasMatch(value)) {
//                 removeError(error: kInvalidEmailError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kEmailNullError);
//                 return "";
//               } else if (!emailValidatorRegExp.hasMatch(value)) {
//                 addError(error: kInvalidEmailError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Email",
//               hintText: "Enter your email",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             obscureText: true,
//             onSaved: (newValue) => password = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kPassNullError);
//               } else if (value.length >= 8) {
//                 removeError(error: kShortPassError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kPassNullError);
//                 return "";
//               } else if (value.length < 8) {
//                 addError(error: kShortPassError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Password",
//               hintText: "Enter your password",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Checkbox(
//                 value: remember,
//                 activeColor: kPrimaryColor,
//                 onChanged: (value) {
//                   setState(() {
//                     remember = value;
//                   });
//                 },
//               ),
//               const Text("Remember me"),
//               const Spacer(),
//               // GestureDetector(
//               //   onTap: () => Navigator.pushNamed(
//               //       context, ForgotPasswordScreen.routeName),
//               //   child: const Text(
//               //     "Forgot Password",
//               //     style: TextStyle(decoration: TextDecoration.underline),
//               //   ),
//               // )
//             ],
//           ),
//           FormError(errors: errors),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 _formKey.currentState!.save();
//                 // if all are valid then attempt to log in
//                 KeyboardUtil.hideKeyboard(context);
//
//                 // Call AuthService to attempt login
//                 try {
//                   await widget.authService.login(email!, password!);
//                   // If login successful, navigate to success screen
//                   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//                 } catch (e) {
//                   // If login fails, show error message
//                   print('Failed to login: $e');
//                   // You can also display an error message to the user here
//                 }
//               }
//             },
//             child: const Text("Continue"),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
//
