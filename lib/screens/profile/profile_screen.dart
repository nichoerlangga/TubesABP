import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../sign_in/sign_in_screen.dart';
import 'account_detail_screen.dart';
import 'package:shop_app/constants.dart';
import '../../screens/input_product/inputPage.dart';
import '../../screens/chat/chatPage.dart';
import '../../screens/favorite/favorite_screen.dart';

class ProfilePic extends StatefulWidget {
  final String name;
  final String imageUrl;

  const ProfilePic({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _image;
  bool _isValidImage = false;
  late AuthService _authService;
  late int? idUser;

  @override
  void initState() {
    super.initState();
    _authService = Get.put(AuthService());
    final userData = _authService.userData;
    idUser = userData["id"];
    debugPrint('Testing image URL: ${widget.imageUrl}');
    _testImageUrl(widget.imageUrl);
  }


  Future<void> _testImageUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 && response.headers['content-type']?.startsWith('image/') == true) {
        debugPrint('Image URL is valid and accessible');
        setState(() {
          _isValidImage = true;
        });
      } else {
        debugPrint('Image URL is not accessible or not a valid image, status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Failed to access image URL: $e');
      // Handle error gracefully, e.g., set a default image or show an error message
      setState(() {
        _isValidImage = false;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        // Call the method to upload the image
        await _uploadImage(_image!);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      final userData = _authService.userData;
      final userId = userData["id"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.0.104:8000/api/profile/update-image/$userId'),
      );

      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successfully updated profile image
        print('Profile image updated successfully.');
        // Update profile image URL
        // _fetchProfileImage();
      } else {
        // Failed to update profile image
        print('Failed to update profile image.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('Profile image URL: ${widget.imageUrl}'); // Log the image URL

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
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : Image.network("http://192.168.0.104:8000/api/users/${idUser}").image,
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
          style: const TextStyle(
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

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';
  final AuthService _authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
    });
  }

  Future<void> _logout() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Obx(() {
              final userData = _authService.userData;
              final String? name = userData["name"];
              final String? imageUrl = userData["image"];
              final String baseUrl = 'http://192.168.0.104:8000/';
              return ProfilePic(
                name: name ?? "Unknown",
                imageUrl: imageUrl != null ? baseUrl + imageUrl : "",
              ); // Pass the user's name and imageUrl to ProfilePic
            }),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () {
                Navigator.pushNamed(context, AccountDetailsScreen.routeName);
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
              press: _logout,
            ),
          ],
        ),
      ),
    );
  }
}