import 'package:fall_in_love_with_beauty/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String name;
  final String mainImageUrl;
  final double ratingPoint;
  final String hours;
  final String location;
  final bool isLike;

  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.hours,
    required this.location,
    required this.isLike,
  });

  factory ProductCard.fromModel({
    required ProductModel model,
  }) {
    return ProductCard(
      id: model.id,
      name: model.name,
      mainImageUrl: model.mainImageUrl,
      ratingPoint: model.ratingPoint,
      hours: model.hours,
      location: model.location,
      isLike: model.isLike,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MyColor.empty,
        boxShadow: [
          BoxShadow(
            color: MyColor.barrier,
            blurRadius: 12.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          color: MyColor.white,
          child: Column(
            children: [
              Image.asset(
                mainImageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 200.0,
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
                          onPressed: () {},
                          icon: isLike
                              ? PhosphorIcon(
                                  PhosphorIcons.heart(PhosphorIconsStyle.fill),
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
                    renderIconAndTitle(
                      title: location,
                      icon: PhosphorIcons.mapPinArea(),
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
