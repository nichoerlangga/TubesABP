import 'dart:convert';
import 'package:http/http.dart' as http;


class Category {
  final int id;
  final String catName;

  Category({
    required this.id,
    required this.catName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      catName: json['CatName'],
    );
  }
}

class CategoryService {
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('http://192.168.0.104:8000/api/products'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonProducts = json.decode(response.body)['category'];
      return jsonProducts.map((jsonProduct) => Category.fromJson(jsonProduct)).toList();
    } else {
      throw Exception('Failed to load category');
    }
  }
}