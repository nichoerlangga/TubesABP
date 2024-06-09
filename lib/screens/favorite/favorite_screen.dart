
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/init_screen.dart';
import '../../services/auth_service.dart';
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
    return GestureDetector(
        onTap: onPress,
        child :  Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  height: 200, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        // product.images[index], // Image URL
                        "http://192.168.0.104:8000/api/images/${product.id}",
                        width: 200, // Adjust the width as needed
                        fit: BoxFit.contain, // Adjust the fit as needed
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
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
        )
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  static String routeName = "/favorite_screen";
  late final Future<List<Product>> futureData; // Change the type to List<Product>
  // final AuthService _authService = Get.find<AuthService>();
  final AuthService _authService = Get.put(AuthService());

  FavoriteScreen({Key? key}) : super(key: key) {
    final userId = _authService.userData?["id"]; // Use null-safe operator '?'
    if (userId != null) {
      // Initialize the future data in the constructor
      futureData = ProductService.fetchWishlist(userId); // Fetch data using ProductService
    } else {
      // If userId is null, initialize futureData with an empty list
      futureData = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitScreen())),
        ),
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: FutureBuilder<List<Product>>( // Change the generic type to List<Product>
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
      ),
    );
  }
}
