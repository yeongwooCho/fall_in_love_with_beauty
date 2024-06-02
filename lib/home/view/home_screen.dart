import 'package:fall_in_love_with_beauty/notification/view/notification_screen.dart';
import 'package:fall_in_love_with_beauty/product/component/horizontal_item_list.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';
import 'package:fall_in_love_with_beauty/product/provider/category_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/colors.dart';
import '../../common/const/data.dart';
import '../../common/const/image_path.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class HomeScreen extends ConsumerWidget {
  static String get routeName => "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '',
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(ImagePath.logoBlack),
        ),
        leadingWidth: 140,
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                context.pushNamed(NotificationScreen.routeName);
              },
              icon: PhosphorIcon(
                PhosphorIcons.bell(),
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ImagePath.banner),
            const SizedBox(height: 40.0),
            const _CategoryContainer(),
            const SizedBox(height: 40.0),
            _TitleAndProductMiniCards(
              title: '추천 뷰티샵',
              products: products,
            ),
            const SizedBox(height: 40.0),
            _TitleAndProductMiniCards(
              title: '최근 본 뷰티샵',
              products: products,
            ),
            const SizedBox(height: 60.0),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _CategoryContainer extends ConsumerWidget {
  const _CategoryContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider).skip(1).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '카테고리',
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: List.generate(
              categories.length,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index != 0 ? 4.0 : 0.0,
                    right: index != categories.length - 1 ? 4.0 : 0.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: MyColor.middleGrey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                      child: Column(
                        children: [
                          Image.asset(
                            '${ImagePath.categoryDirectory}$index.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            categories[index],
                            style: MyTextStyle.minimumRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAndProductMiniCards extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const _TitleAndProductMiniCards({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: MyTextStyle.bodyTitleMedium,
          ),
        ),
        const SizedBox(height: 8.0),
        HorizontalItemList(products: products),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.lightGrey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final title = footerData[index];

            return Text(
              title,
              style: (index == 0)
                  ? MyTextStyle.minimumRegular.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyColor.darkGrey,
                    )
                  : MyTextStyle.minimumRegular.copyWith(
                      color: MyColor.darkGrey,
                    ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 4.0);
          },
          itemCount: footerData.length,
        ),
      ),
    );
  }
}
