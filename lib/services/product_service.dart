// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../models/Product.dart';
//
// class ProductService {
//
//   static Future<List<Product>> fetchProducts() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.0.104:8000/api/products'),
//         headers: {"Accept": "application/json"},
//       ).timeout(Duration(seconds: 45));
//
//       if (response.statusCode == 200) {
//         List<dynamic> productList = json.decode(response.body)['products'];
//         List<Product> products = productList.map((data) => Product.fromJson(data)).toList();
//         return products;
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error: $e'); // Print the error for debugging
//       rethrow;
//     }
//   }
//
//   static Future<Map<String, dynamic>> fetchProductDetail(int id) async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.0.104:8000/api/product/$id'),
//         headers: {"Accept": "application/json"},
//       );
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to load product detail');
//       }
//     } catch (e) {
//       print('Error: $e'); // Print the error for debugging
//       rethrow;
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/Product.dart';

class ProductService {

  static const String baseUrl = 'http://192.168.0.104:8000/api';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
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

  static Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/product/$id'),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> productData = json.decode(response.body);
        return Product.fromJson(productData);
      } else {
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      print('Error: $e'); // Print the error for debugging
      rethrow;
    }
  }

  static Future<Uint8List> fetchImages(int productId) async {
    final response = await http.get(Uri.parse('http://192.168.0.104:8000/api/images/$productId'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, return the image data
      return response.bodyBytes;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load images');
    }
  }




}
