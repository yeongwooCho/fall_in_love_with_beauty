import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';
import 'package:fall_in_love_with_beauty/product/provider/category_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:fall_in_love_with_beauty/product/view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../user/provider/user_provider.dart';
import '../component/product_card.dart';

class ProductScreen extends ConsumerStatefulWidget {
  static String get routeName => "product";

  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsWithCategoryProvider);
    final selectedCategory = ref.watch(categorySelectedProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '뷰티샵'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: HorizontalButtonList(buttons: [
                ...CategoryStatus.values.map(
                  (e) => HorizontalButtonModel(
                    title: e.label,
                    onTap: () {
                      ref
                          .read(categorySelectedProvider.notifier)
                          .update((state) => e);
                    },
                  ),
                ),
              ],
              initialSelectedIndex: CategoryStatus.values.indexOf(
                selectedCategory,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];

                return InkWell(
                  onTap: () {
                    ref.read(userProvider.notifier).updateRecentlyViewedItems(
                        recentlyViewedItem: product.id);

                    context.pushNamed(
                      ProductDetailScreen.routeName,
                      pathParameters: {'id': product.id},
                    );
                  },
                  child: ProductCard.fromModel(model: product),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20.0);
              },
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}
