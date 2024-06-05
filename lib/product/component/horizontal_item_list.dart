import 'package:fall_in_love_with_beauty/product/component/product_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../user/provider/user_provider.dart';
import '../model/product_model.dart';
import '../view/product_detail_screen.dart';

class HorizontalItemList extends ConsumerWidget {
  final List<ProductModel> products;

  const HorizontalItemList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ref
                  .read(userProvider.notifier)
                  .updateRecentlyViewedItems(recentlyViewedItem: product.id);

              context.pushNamed(
                ProductDetailScreen.routeName,
                pathParameters: {'id': product.id},
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
