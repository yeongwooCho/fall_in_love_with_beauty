import 'package:fall_in_love_with_beauty/product/component/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/default_button.dart';
import '../../common/component/divider_container.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
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

    final fullWidth = MediaQuery.of(context).size.width;

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '뷰티샵 상세보기'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: PrimaryButton(
          onPressed: () {},
          child: const Text('예약하기'),
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
                    '1:1 맞춤 헤어 컨설팅을 추구하여 특별함을 느낄 수 있는 공간에서 감각적인 디자인을 제안하고 편안한 휴식을 제공하여 고객님의 행복함을 항상 생각합니다.\n\n저희 헤어원씽만의 노하우와 트랜디한 헤어스타일로 완벽한 1:1 맞춤 헤어 컨설팅을 고객님께 선사해 드리겠습니다.\n\n매월 1,2주 일요일 휴무\n매월 3,4주 화요일 휴무',
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: MyColor.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            const DividerContainer(),
          ],
        ),
      ),
    );
  }
}
