import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add a Row with the logo and "Atlas Marketplace" text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/atlasLogo.svg',
                height: 32, // Adjust the height as needed
                width: 56, // Adjust the width as needed
              ),
              const SizedBox(width: 8), // Space between the logo and text
              Expanded(
                child: Text(
                  'Atlas Marketplace',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8DBCFA), // Set your desired color here
                  ),
                  overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
                ),
              ),
            ],
          ),
        ),
        // Existing Row with SearchField
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SearchField()),
              const SizedBox(width: 8),
              // Add any other widgets like IconBtnWithCounter here if needed
            ],
          ),
        ),
      ],
    );
  }
}
