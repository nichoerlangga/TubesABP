// class Product {
//   final int id;
//   final String title;
//   final String description;
//   final int price;
//   final int category;
//   final String condition;
//
//   Product({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.category,
//     required this.condition,
//
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       title: json['Title'],
//       description: json['Description'],
//       price: json['Price'],
//       category: json['Category'],
//       condition: json['Condition'],
//
//     );
//   }
//
//   get images => null;
// }

class Product {
  final int id;
  final int sellerId;
  final String title;
  final String description;
  final int price;
  final int category;
  final String condition;
  final List<String> images;

  Product({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.condition,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sellerId: json['SellerID'],
      title: json['Title'],
      description: json['Description'],
      price: json['Price'],
      category: json['Category'],
      condition: json['Condition'],
      images: List<String>.from(json['images']),
    );
  }
}


class Images {
  final int id;
  final int productId;
  final String images;

  Images({
    required this.id,
    required this.productId,
    required this.images,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      productId: json['ProductID'],
      images: json['Images'],
    );
  }
}

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
