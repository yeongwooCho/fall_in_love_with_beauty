import 'package:fall_in_love_with_beauty/common/component/show/show_component_modal_bottom_sheet.dart';
import 'package:fall_in_love_with_beauty/product/component/product_card.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:fall_in_love_with_beauty/product/view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/colors.dart';
import '../../common/const/image_path.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class MapScreen extends ConsumerWidget {
  static String get routeName => "map";

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider).first;

    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: PhosphorIcon(
          PhosphorIcons.mapPinArea(),
          size: 32.0,
        ),
        backgroundColor: MyColor.primary,
        foregroundColor: MyColor.white,
      ),
      appbar: const DefaultAppBar(title: '주변 뷰티샵'),
      child: ClipRRect(
        child: InkWell(
          onTap: () {
            showCustomModalBottomSheet(
              context: context,
              bottomSheetWidget: SizedBox(
                height: 370.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(
                        ProductDetailScreen.routeName,
                        pathParameters: {'id': product.id},
                      );
                    },
                    child: ProductCard.fromModel(model: product),
                  ),
                ),
              ),
            );
          },
          child: Image.asset(
            ImagePath.map,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
