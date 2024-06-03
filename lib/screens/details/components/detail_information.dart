import 'package:flutter/material.dart';

import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';

class DetailInformation extends StatelessWidget {
  const DetailInformation({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category: ' + product.category,
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