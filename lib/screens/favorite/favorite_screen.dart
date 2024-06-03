import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import '../details/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  static String routeName = "/favorite_screen";

  const FavoriteScreen({super.key});

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
