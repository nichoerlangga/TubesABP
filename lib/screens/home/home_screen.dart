import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/product_service.dart';
import '../../constants.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              Categories(),
              PopularProducts(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/atlasLogo.svg',
                height: 32,
                width: 56,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Atlas Marketplace',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8DBCFA),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: SearchField()),
              const SizedBox(width: 8),
              // Add any other widgets like IconBtnWithCounter here if needed
            ],
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF8DBCFA).withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: searchOutlineInputBorder,
          focusedBorder: searchOutlineInputBorder,
          enabledBorder: searchOutlineInputBorder,
          hintText: "Search product",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
              (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF8DBCFA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<Product>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = ProductService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Product> products = snapshot.data!;

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final Product product = products[index];
              // Log the URLs for debugging
              print('Product ${product.title} image URLs: ${product.images}');

              return ProductCard(
                product: product,
                onPress: () => Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(
                    product: product,
                  ),
                ),
                images: [
                  'http://192.168.0.104:8000/storage/images/NzAYAHSTSsgetu7K4hdiapC1xNnnO4Cf7rAacl5g.jpg'
                ],
              );
            },
          );
        }
      },
    );
  }
}

// class _PopularProductsState extends State<PopularProducts> {
//   late Future<List<Product>> futureData;
//
//   @override
//   void initState() {
//     super.initState();
//     futureData = ProductService.fetchProducts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Product>>(
//       future: futureData,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final List<Product> products = snapshot.data!;
//
//           return GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.7,
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 16,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final Product product = products[index];
//               // Log the URLs for debugging
//               print('Product ${product.title} image URLs: ${product.images}');
//
//               return FutureBuilder<List<String>?>(
//                 future: ProductService.fetchImages(product.id),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No images found'));
//                   } else {
//                     final List<String> images = snapshot.data!;
//
//                     return ProductCard(
//                       product: product,
//                       onPress: () => Navigator.pushNamed(
//                         context,
//                         DetailsScreen.routeName,
//                         arguments: ProductDetailsArguments(
//                           product: product,
//                         ),
//                       ),
//                       images: images,
//                     );
//                   }
//                 },
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;
  final List<String> images; // List of image URLs associated with the product
  final GestureTapCallback onPress;

  const ProductCard({
    Key? key,
    required this.product,
    required this.images,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Container(
            height: 150, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  images[index], // Image URL
                  width: 150, // Adjust the width as needed
                  fit: BoxFit.cover, // Adjust the fit as needed
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    // Handle image load error
                    return Container(
                      width: 150,
                      color: Colors.grey[200],
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rp. ${formatNumberWithDot(product.price)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              // Add other widgets as needed
            ],
          )
        ],
      ),
    );
  }
}

// class ProductCard extends StatelessWidget {
//   final Product product;
//   final Future<Uint8List> imageData; // Future containing image data
//   final GestureTapCallback onPress;
//
//   const ProductCard({
//     Key? key,
//     required this.product,
//     required this.imageData,
//     required this.onPress,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPress,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FutureBuilder<Uint8List>(
//             future: imageData,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Show loading indicator while fetching image data
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 // Display the image using Image.memory with the retrieved image data
//                 return Image.memory(
//                   snapshot.data!,
//                   width: 150, // Adjust the width as needed
//                   height: 150, // Adjust the height as needed
//                   fit: BoxFit.cover, // Adjust the fit as needed
//                   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                     // Handle image load error
//                     return Container(
//                       width: 150,
//                       height: 150,
//                       color: Colors.grey[200],
//                       child: Icon(Icons.error, color: Colors.red),
//                     );
//                   },
//                 );
//               }
//             },
//           ),
//           const SizedBox(height: 8),
//           Text(
//             product.title,
//             style: Theme.of(context).textTheme.bodyMedium,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Rp. ${formatNumberWithDot(product.price)}",
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: kPrimaryColor,
//                 ),
//               ),
//               // Add other widgets as needed
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
//


class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF8DBCFA).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}