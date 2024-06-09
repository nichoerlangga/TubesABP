import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import '../../models/Product.dart';
import '../../screens/chat/chatPage.dart';
import '../../../constants.dart';

// Komponen DetailInformation
class DetailInformation extends StatelessWidget {
  final Product product;
  final List<Category> categories;

  const DetailInformation({required this.product, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Find the category object corresponding to the product's category ID
    Category? productCategory = categories.firstWhere(
          (category) => category.id == product.category,
      orElse: () => Category(id: 0, catName: 'Unknown'), // Default category if not found
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category: ' + productCategory.catName, // Display category name
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0), // Adds some space between the texts
          Text(
            'Kondisi: ' + product.condition,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0), // Adds some space between the texts
          Text(
            'Lokasi: Bandung',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     padding: const EdgeInsets.all(16),
        //     width: 48,
        //     decoration: BoxDecoration(
        //       color: product.isFavourite
        //           ? const Color(0xFFFFE6E6)
        //           : const Color(0xFFF5F6F9),
        //       borderRadius: const BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         bottomLeft: Radius.circular(20),
        //       ),
        //     ),
        //     child: SvgPicture.asset(
        //       "assets/icons/Heart Icon_2.svg",
        //       colorFilter: ColorFilter.mode(
        //           product.isFavourite
        //               ? const Color(0xFFFF4848)
        //               : const Color(0xFFDBDEE4),
        //           BlendMode.srcIn),
        //       height: 16,
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Text(
              'Rp. ' + formatNumberWithDot(product.price),
              style: TextStyle(color: kPrimaryColor, fontSize: 22, fontWeight: FontWeight.bold),
            )
        )
      ],
    );
  }
}

String formatNumberWithDot(int number) {
  String strNumber = number.toString();
  String formattedNumber = '';

  int counter = 0;
  for (int i = strNumber.length - 1; i >= 0; i--) {
    counter++;
    formattedNumber = strNumber[i] + formattedNumber;
    if (counter == 3 && i != 0) {
      formattedNumber = '.' + formattedNumber;
      counter = 0;
    }
  }

  return formattedNumber;
}

class ProductImages extends StatelessWidget {
  final Product? product;

  const ProductImages({required this.product});

  @override
  Widget build(BuildContext context) {
    if (product == null || product!.images == null || product!.images!.isEmpty) {
      // If product is null or images list is null or empty, return a placeholder widget
      return Container(); // Placeholder widget or empty container
    }

    // If product and images list are not null or empty, display product images
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: product!.id.toString(),
              child: Image.asset(product!.images![0]), // Access images list with null safety
            ),
          ),
        ),
      ],
    );
  }
}


// Komponen TopRoundedContainer
class TopRoundedContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  const TopRoundedContainer({
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final product = agrs.product;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      DetailInformation(product: product, categories: [],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ChatPage.routeName);
              },
              child: const Text("Chat"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
