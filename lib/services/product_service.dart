import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductService {
  final String baseUrl = 'http://your-api-url.com/api';

  Future<void> addProduct({
    required String userId,
    required String name,
    required String description,
    required double price,
    required String category,
    required String condition,
    required XFile? image,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/products');
      final request = http.MultipartRequest('POST', uri);

      request.fields['SellerID'] = userId;
      request.fields['Title'] = name;
      request.fields['Description'] = description;
      request.fields['Price'] = price.toString();
      request.fields['Category'] = category;
      request.fields['Condition'] = condition;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('Images', image.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful response
        print('Product added successfully');
      } else {
        // Handle error response
        print('Failed to add product: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error adding product: $e');
    }
  }
}
