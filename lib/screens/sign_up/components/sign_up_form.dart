import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../login_success/register_success_screen.dart';
import '../../../services/auth_service.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? location;
  String? email;
  String? password;
  String? confirm_password;
  final List<String?> errors = [];
  final AuthService _authService = AuthService();

  final String kNameNullError = "Please enter your name";
  final String kLocationNullError = "Please enter your location";

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

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _authService.register(name!, email!, password!, location!);
        Navigator.pushNamed(context, RegisterSuccessScreen.routeName);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) => name = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNameNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNameNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Enter your name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onSaved: (newValue) => location = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kLocationNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kLocationNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Location",
              hintText: "Enter your location",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
            ),
          ),
          const SizedBox(height: 20),
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
              password = value;
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
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => confirm_password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty && password == value) {
                removeError(error: kMatchPassError);
              }
              confirm_password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if ((password != value)) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Re-enter Password",
              hintText: "Re-enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// import '../../../components/custom_surfix_icon.dart';
// import '../../../components/form_error.dart';
// import '../../../constants.dart';
// import '../../login_success/register_success_screen.dart';
//
// class SignUpForm extends StatefulWidget {
//   const SignUpForm({super.key});
//
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }
//
// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? name;
//   String? location;
//   String? email;
//   String? password;
//   String? confirm_password;
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
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             onSaved: (newValue) => name = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kNameNullError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kNameNullError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Name",
//               hintText: "Enter your name",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             onSaved: (newValue) => location = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kLocationNullError);
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kLocationNullError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Location",
//               hintText: "Enter your location",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
//             ),
//           ),
//           const SizedBox(height: 20),
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
//               password = value;
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
//           TextFormField(
//             obscureText: true,
//             onSaved: (newValue) => confirm_password = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kPassNullError);
//               } else if (value.isNotEmpty && password == value) {
//                 removeError(error: kMatchPassError);
//               }
//               confirm_password = value;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kPassNullError);
//                 return "";
//               } else if ((password != value)) {
//                 addError(error: kMatchPassError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Re-enter Password",
//               hintText: "Re-enter your password",
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//             ),
//           ),
//           FormError(errors: errors),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 _formKey.currentState!.save();
//                 // if all are valid then go to success screen
//                 Navigator.pushNamed(context, RegisterSuccessScreen.routeName);
//               }
//             },
//             child: const Text("Continue"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // constants.dart
// const String kNameNullError = "Please enter your name";
// const String kLocationNullError = "Please enter your location";
// const String kEmailNullError = "Please enter your email";
// const String kInvalidEmailError = "Please enter a valid email";
// const String kPassNullError = "Please enter your password";
// const String kShortPassError = "Password is too short";
// const String kMatchPassError = "Passwords don't match";
//
// // custom_surfix_icon.dart and form_error.dart should remain the same
