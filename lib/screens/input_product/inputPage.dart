import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/services/auth_service.dart';

class InputProductPage extends StatefulWidget {
  static String routeName = "/input_product";

  const InputProductPage({Key? key}) : super(key: key);

  @override
  _InputProductPageState createState() => _InputProductPageState();
}

class _InputProductPageState extends State<InputProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  late AuthService _authService;
  int? _SellerID; // Use nullable int for _SellerID
  int? idUser; // Use nullable int for _SellerID

  // Initialize other variables with default values
  String _Title = '';
  String _Description = '';
  int _Price = 0;
  int _Category = 0;
  String _Condition = '';

  @override
  void initState() {
    super.initState();
    _authService = AuthService(); // Initialize _authService if needed
    _fetchSellerID(); // Call _fetchSellerID() in initState to initialize _SellerID
  }

  // Function to fetch seller ID
  Future<void> _fetchSellerID() async {
    _authService = Get.put(AuthService());
    final userData = _authService.userData;
    idUser = userData["id"];
    setState(() {
      _SellerID = idUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Product"),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                onSaved: (value) => _Title = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter the product name' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Description'),
                onSaved: (value) => _Description = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the product description'
                    : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _Price = int.tryParse(value ?? '') ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                onSaved: (value) => _Category = int.tryParse(value ?? '') ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Category';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Condition'),
                onSaved: (value) => _Condition = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter the Condition' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                _image!,
                height: 100,
                width: 100,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProduct() async {
    if (_SellerID == null) {
      print('Seller ID is null. Ensure _fetchSellerID() completes before saving product.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_SellerID.toString());
      print(_Title);
      print(_Description);
      print(_Price.toString());
      print(_Category.toString());
      print(_Condition);

      // Print image details if an image is selected
      if (_image != null) {
        print('Image path: ${_image!.path}');
        print('Image size: ${_image!.lengthSync()} bytes');
        print('Image type: ${_image!.path.split('.').last}');
      } else {
        print('No image selected.');
      }
      try {
        var uri = Uri.parse('http://192.168.0.104:8000/api/upload/add');

        var request = http.MultipartRequest('POST', uri);
        request.fields['SellerID'] = _SellerID.toString();
        request.fields['Title'] = _Title;
        request.fields['Description'] = _Description;
        request.fields['Price'] = _Price.toString(); // Convert to String
        request.fields['Category'] = _Category.toString(); // Convert to String
        request.fields['Condition'] = _Condition;

        // Add image file if selected
        if (_image != null) {
          request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
        }

        var response = await request.send();
        if (response.statusCode == 200) {
          print('Product saved successfully.');
          // Handle success, navigate to another screen, show success message, etc.
        } else {
          print('Failed to save product. Status Code: ${response.statusCode}');
          // Handle failure, show error message, etc.
        }
      } catch (e) {
        print('Error saving product: $e');
        // Handle error, show error message, etc.
      }
    }
  }

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
