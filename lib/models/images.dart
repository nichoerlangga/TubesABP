import 'dart:convert';
import 'package:http/http.dart' as http;

class Images {
  final int productID;
  final List<String> images;

  Images({
    required this.productID,
    required this.images,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    // Parse the list of images from JSON and map them to strings
    List<String> parsedImages = (json['images'] as List<dynamic>).map((image) => image.toString()).toList();

    return Images(
      productID: json['productID'],
      images: parsedImages, // Assign the parsed images to the images parameter
    );
  }
}

class ImageService {
  static Future<List<Images>> fetchImage() async {
    final response = await http.get(Uri.parse('http://192.168.0.104:8000/api/products/home'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonProducts = json.decode(response.body);
      return jsonProducts.map((jsonProduct) => Images.fromJson(jsonProduct)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}

