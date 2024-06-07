import 'package:fall_in_love_with_beauty/product/component/product_card.dart';
import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:fall_in_love_with_beauty/product/view/designer_detail_screen.dart';
import 'package:fall_in_love_with_beauty/reserve/view/create_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/default_button.dart';
import '../../common/component/divider_container.dart';
import '../../common/component/show/show_component_modal_bottom_sheet.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/designer_card.dart';
import '../component/result_modal_bottom_sheet.dart';
import '../provider/product_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'product_detail';

  final String id;

  const ProductDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final ScrollController scrollController = ScrollController();
  int count = 1;

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productDetailProvider(widget.id));

    List<Widget> results = [];

    for (DesignerModel designer in product.designers) {
      for (String result in designer.resultImageUrls) {
        results.add(
          InkWell(
            onTap: () {
              showCustomModalBottomSheet(
                context: context,
                bottomSheetWidget: ResultModalBottomSheet(
                  productId: product.id,
                  designer: designer,
                  resultImageUrl: result,
                ),
              );
            },
            child: Image.asset(
              result,
              width: (MediaQuery.of(context).size.width - 48 - 16) / 3,
            ),
          ),
        );
      }
    }

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '뷰티샵 상세보기'),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: MyColor.barrier,
            )
          ],
          color: MyColor.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: PrimaryButton(
            onPressed: () {
              context.pushNamed(
                CreateReservationScreen.routeName,
                pathParameters: {'id': product.id},
              );
            },
            child: const Text('예약하기'),
          ),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ProductCard.fromModel(
                model: product,
                isDetail: true,
              ),
            ),
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '뷰티샵 소개',
                    style: MyTextStyle.bodyTitleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    product.description,
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: MyColor.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '디자이너',
                    style: MyTextStyle.bodyTitleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final designer = product.designers[index];

                      return InkWell(
                        onTap: () {
                          context.pushNamed(
                            DesignerDetailScreen.routeName,
                            pathParameters: {'id': designer.id},
                          );
                        },
                        child: DesignerCard.fromModel(
                          model: designer,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 24.0,
                        color: MyColor.middleGrey,
                      );
                    },
                    itemCount: product.designers.length,
                  ),
                ],
              ),
            ),
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '시술',
                    style: MyTextStyle.bodyTitleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: results,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
