import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/product/provider/category_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

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
    final categories = ref.watch(categoriesProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '뷰티샵'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: HorizontalButtonList(buttons: [
              ...categories.map(
                (e) => HorizontalButtonModel(
                  title: e,
                  onTap: () {},
                ),
              ),
            ]),
          ),
          Text('product'),
        ],
      ),
    );
  }
}
