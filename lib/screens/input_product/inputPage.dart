import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/constants.dart';

import '../init_screen.dart';

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

  // Initialize variables with default values
  String _productName = '';
  String _productDescription = '';
  double _productPrice = 0.0;
  String _category = '';
  String _condition = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitScreen())),
        ),
        title: Text(
          "Input Product",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Product Name'),
                  onSaved: (value) {
                    _productName = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the products name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Product Description'),
                  onSaved: (value) {
                    _productDescription = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the products description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Product Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _productPrice = double.tryParse(value ?? '') ?? 0.0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the products price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  onSaved: (value) {
                    _category = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the products category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Condition'),
                  onSaved: (value) {
                    _condition = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the products condition';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _getImage();
                  },
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: _image == null
                          ? Text('Tap to select image from gallery')
                          : Image.file(
                        _image!,
                        height: 150,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Process the input data
                    }
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
