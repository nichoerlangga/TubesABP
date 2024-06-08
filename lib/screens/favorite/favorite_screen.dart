import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import '../details/details_screen.dart';
import '../home/home_screen.dart';
import '../init_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final GestureTapCallback onPress;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  get width => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Ensure width is defined or removed if not needed
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(product.images[0]),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rp. ${formatNumberWithDot(product.price)}", // Use formatNumberWithDot
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
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  static String routeName = "/favorite_screen";

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InitScreen()),
            ),
        ),
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: demoProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: demoProducts[index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments:
                      ProductDetailsArguments(product: demoProducts[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
