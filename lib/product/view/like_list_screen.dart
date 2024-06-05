import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/common/component/show/show_cupertino_alert.dart';
import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/product/component/designer_card.dart';
import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:fall_in_love_with_beauty/product/view/designer_detail_screen.dart';
import 'package:fall_in_love_with_beauty/product/view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../user/provider/user_provider.dart';
import '../component/product_card.dart';

class LikeListScreen extends ConsumerStatefulWidget {
  static String get routeName => "like_list";

  const LikeListScreen({super.key});

  @override
  ConsumerState<LikeListScreen> createState() => _LikeListScreenState();
}

class _LikeListScreenState extends ConsumerState<LikeListScreen> {
  bool isBeauty = true;

  @override
  Widget build(BuildContext context) {
    final productsWithLike = ref.watch(productsWithLikeProvider);
    final designersWithLike = ref.watch(designersWithLikeProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '뷰티샵'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: HorizontalButtonList(buttons: [
              HorizontalButtonModel(
                title: '뷰티샵',
                onTap: () {
                  setState(() {
                    isBeauty = true;
                  });
                },
              ),
              HorizontalButtonModel(
                title: '디자이너',
                onTap: () {
                  setState(() {
                    isBeauty = false;
                  });
                },
              ),
            ]),
          ),
          isBeauty
              ? Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final product = productsWithLike[index];

                      return InkWell(
                        onTap: () {
                          ref
                              .read(userProvider.notifier)
                              .updateRecentlyViewedItems(
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
                    itemCount: productsWithLike.length,
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final designer = designersWithLike[index];

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.pushNamed(
                                  DesignerDetailScreen.routeName,
                                  pathParameters: {'id': designer.id},
                                );
                              },
                              child: DesignerCard.fromModel(model: designer),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showCustomCupertinoAlert(
                                context: context,
                                titleWidget: Text('좋아요를 수정하시겠습니까?'),
                                completeText: '확인',
                                completeFunction: () {
                                  ref
                                      .read(designerProvider.notifier)
                                      .updateLike(
                                          id: designer.id,
                                          isLike: !designer.isLike);
                                  context.pop();
                                },
                                cancelText: '취소',
                                cancelFunction: () {
                                  context.pop();
                                },
                              );
                            },
                            icon: PhosphorIcon(
                              PhosphorIcons.heart(PhosphorIconsStyle.fill),
                              size: 32.0,
                              color: MyColor.primary,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 24.0,
                        color: MyColor.middleGrey,
                      );
                    },
                    itemCount: designersWithLike.length,
                  ),
                ),
        ],
      ),
    );
  }
}
