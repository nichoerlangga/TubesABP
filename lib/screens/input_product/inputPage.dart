import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputProductPage extends StatefulWidget {
  const InputProductPage({Key? key}) : super(key: key);

  @override
  _InputProductPageState createState() => _InputProductPageState();
}

class _InputProductPageState extends State<InputProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

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
        title: Text('Input Product Page'),
      ),
      body: Form(
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
                    return 'Please enter the product name';
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
                    return 'Please enter the product description';
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
                    return 'Please enter the product price';
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
                    return 'Please enter the product category';
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
                    return 'Please enter the product condition';
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
                      File(_image!.path),
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
    );
  }

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
