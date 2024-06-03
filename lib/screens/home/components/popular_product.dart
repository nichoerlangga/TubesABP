import 'package:flutter/material.dart';

import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SizedBox(
          height: 500, // Set an appropriate height for your list
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: 20, // Space between each item
              runSpacing: 20, // Space between each line
              children: [
                ...List.generate(
                  demoProducts.length,
                      (index) {
                    if (demoProducts[index].isPopular) {
                      return ProductCard(
                        product: demoProducts[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                              product: demoProducts[index]),
                        ),
                      );
                    }
                    return const SizedBox.shrink(); // Default width and height is 0
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
