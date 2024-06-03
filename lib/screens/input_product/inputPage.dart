import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/services/product_service.dart';

class InputProductPage extends StatefulWidget {
  static String routeName = "/input_product";

  const InputProductPage({Key? key});

  @override
  _InputProductPageState createState() => _InputProductPageState();
}

class _InputProductPageState extends State<InputProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  String _productName = '';
  String _productDescription = '';
  double _productPrice = 0.0;
  String _category = '';
  String _condition = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Input Product",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kPrimaryColor),
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
                // Form fields
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _submitProduct(authProvider.userId),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _submitProduct(String? userId) async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You must be logged in to add a product.'),
      ));
      return;
    }

    // Validate form
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Add product
      try {
        await ProductService().addProduct(
          userId: userId,
          name: _productName,
          description: _productDescription,
          price: _productPrice,
          category: _category,
          condition: _condition,
          image: _image,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product added successfully.'),
        ));
      } catch (error) {
        // Show error message if adding product fails
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add product: $error'),
        ));
      }
    }
  }
}
