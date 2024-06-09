import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Product.dart';

class ProductService {

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.104:8000/api/products'),
        headers: {"Accept": "application/json"},
      ).timeout(Duration(seconds: 45));

      if (response.statusCode == 200) {
        List<dynamic> productList = json.decode(response.body)['products'];
        List<Product> products = productList.map((data) => Product.fromJson(data)).toList();
        return products;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e'); // Print the error for debugging
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> fetchProductDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.104:8000/api/product/$id'),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      print('Error: $e'); // Print the error for debugging
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> fetchImage() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.104:8000/storage/images/NzAYAHSTSsgetu7K4hdiapC1xNnnO4Cf7rAacl5g.jpg'),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e'); // Print the error for debugging
      rethrow;
    }
  }
}
