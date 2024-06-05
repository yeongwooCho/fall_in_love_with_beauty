import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/text_styles.dart';

class ProductMiniCard extends StatelessWidget {
  final ProductModel product;

  const ProductMiniCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            color: MyColor.barrier,
          ),
        ],
        borderRadius: BorderRadius.circular(16.0),
        color: MyColor.empty,
      ),
      width: 180.0,
      height: 220.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              product.mainImageUrl,
              fit: BoxFit.cover,
              height: 105,
            ),
            Container(
              height: 115.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16.0),
                ),
                color: MyColor.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.name,
                      style: MyTextStyle.bodyBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.star(PhosphorIconsStyle.fill),
                          size: 24.0,
                          color: MyColor.primary,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          product.ratingPoint.toStringAsFixed(2),
                          style: MyTextStyle.descriptionRegular.copyWith(
                            color: MyColor.darkGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
