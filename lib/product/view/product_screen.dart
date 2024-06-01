import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/product/provider/category_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/product_card.dart';

class ProductScreen extends ConsumerStatefulWidget {
  static String get routeName => "product";

  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    final categories = ref.watch(categoriesProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '뷰티샵'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: HorizontalButtonList(buttons: [
              ...categories.map(
                (e) => HorizontalButtonModel(
                  title: e,
                  onTap: () {},
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
            
                return ProductCard.fromModel(model: product);
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
