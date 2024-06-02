import 'package:fall_in_love_with_beauty/product/component/product_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/product_model.dart';
import '../view/product_detail_screen.dart';

class HorizontalItemList extends StatelessWidget {
  final List<ProductModel> products;

  const HorizontalItemList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 222.0,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () {
              context.pushNamed(
                ProductDetailScreen.routeName,
                pathParameters: {'id': product.id.toString()},
              );
            },
            child: ProductMiniCard(product: product),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16.0);
        },
      ),
    );
  }
}
