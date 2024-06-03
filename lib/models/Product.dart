import 'package:flutter/material.dart';

class Product {
  final int id, sellerID;
  final String title, description, condition, category;
  final List<String> images;
  final double rating;
  final int price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.sellerID,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.condition,
    required this.category,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    sellerID: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Wireless Controller for PS4™",
    price: 64999,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
    condition: "Baru",
    category: "Elektronik",
  ),
  Product(
    id: 2,
    sellerID: 1,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike Sport White - Man Pant",
    price: 500000,
    description: description,
    rating: 4.1,
    isPopular: true,
    condition: "Baru",
    category: "Pakaian",
  ),
  Product(
    id: 3,
    sellerID: 2,
    images: [
      "assets/images/glap.png",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 365000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
    condition: "Baru",
    category: "Pakaian",
  ),
  Product(
    id: 4,
    sellerID: 2,
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Logitech Head",
    price: 20000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    condition: "Baru",
    category: "Elektronik",
  ),
  Product(
    id: 4,
    sellerID: 3,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Wireless Controller for PS4™",
    price: 649999,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
    condition: "Baru",
    category: "Elektronik",
  ),
  Product(
    id: 5,
    sellerID: 3,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike Sport White - Man Pant",
    price: 500000,
    description: description,
    rating: 4.1,
    isPopular: true,
    condition: "Baru",
    category: "Pakaian",
  ),
  Product(
    id: 6,
    sellerID: 3,
    images: [
      "assets/images/glap.png",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 365000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
    condition: "Baru",
    category: "Pakaian",
  ),
  Product(
    id: 7,
    sellerID: 3,
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Logitech Head",
    price: 200000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    condition: "Baru",
    category: "Elektronik",
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
