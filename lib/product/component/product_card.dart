import 'package:fall_in_love_with_beauty/product/model/product_model.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/component/show/show_cupertino_alert.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';

class ProductCard extends ConsumerWidget {
  final String id;
  final String name;
  final String mainImageUrl;
  final double ratingPoint;
  final String hours;
  final String location;
  final bool isLike;

  final bool isDetail; // 상세 페이지 여부

  final String? heroKey; // 히어로 위젯 키

  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.hours,
    required this.location,
    required this.isLike,
    this.isDetail = false,
    this.heroKey,
  });

  factory ProductCard.fromModel({
    required ProductModel model,
    bool isDetail = false,
  }) {
    return ProductCard(
      heroKey: model.id,
      id: model.id,
      name: model.name,
      mainImageUrl: model.mainImageUrl,
      ratingPoint: model.ratingPoint,
      hours: model.hours,
      location: model.location,
      isLike: model.isLike,
      isDetail: isDetail,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.empty,
        boxShadow: isDetail
            ? []
            : [
                const BoxShadow(
                  color: MyColor.barrier,
                  blurRadius: 12.0,
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: isDetail
            ? BorderRadius.circular(0.0)
            : BorderRadius.circular(16.0),
        child: Container(
          color: MyColor.white,
          child: Column(
            children: [
              Hero(
                tag: ObjectKey(heroKey),
                child: Image.asset(
                  mainImageUrl,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 16.0,
                  bottom: 16.0,
                  left: 16.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: MyTextStyle.bodyBold,
                        ),
                        IconButton(
                          onPressed: () {
                            showCustomCupertinoAlert(
                              context: context,
                              titleWidget: Text('좋아요를 수정하시겠습니까?'),
                              completeText: '확인',
                              completeFunction: () {
                                ref
                                    .read(productProvider.notifier)
                                    .updateLike(id: id, isLike: !isLike);
                                context.pop();
                              },
                              cancelText: '취소',
                              cancelFunction: () {
                                context.pop();
                              },
                            );
                          },
                          icon: isLike
                              ? PhosphorIcon(
                                  PhosphorIcons.heart(
                                      PhosphorIconsStyle.fill),
                                  size: 40.0,
                                  color: MyColor.primary,
                                )
                              : PhosphorIcon(
                                  PhosphorIcons.heart(),
                                  size: 40.0,
                                  color: MyColor.middleGrey,
                                ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        renderIconAndTitle(
                          title: ratingPoint.toStringAsFixed(2),
                          icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
                        ),
                        const SizedBox(width: 12.0),
                        renderIconAndTitle(
                          title: hours,
                          icon: PhosphorIcons.clock(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.mapPinArea(),
                          size: 24.0,
                          color: MyColor.primary,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            location,
                            style: MyTextStyle.descriptionRegular.copyWith(
                              color: MyColor.darkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderIconAndTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        PhosphorIcon(
          icon,
          size: 24.0,
          color: MyColor.primary,
        ),
        const SizedBox(width: 4.0),
        Text(
          title,
          style: MyTextStyle.descriptionRegular.copyWith(
            color: MyColor.darkGrey,
          ),
        ),
      ],
    );
  }
}
