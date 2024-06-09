import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import '../../services/product_service.dart';
import '../details/details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final GestureTapCallback onPress;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onPress, required String imageUrl,
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
  late final Future<List<Product>> futureData; // Change the type to List<Product>

  FavoriteScreen({Key? key}) : super(key: key) {
    // Initialize the future data in the constructor
    futureData = ProductService.fetchProducts(); // Fetch data using ProductService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>( // Change the generic type to List<Product>
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

                return ProductCard(
                  product: product,
                  onPress: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(
                      product: product,
                    ),
                  ), imageUrl: '',
                );
              },
            );
          }
        },
      ),
    );
  }
}
