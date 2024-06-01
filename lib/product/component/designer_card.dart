import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';

class DesignerCard extends StatelessWidget {
  final String id;
  final String name;
  final String thumbnail;
  final String mainImageUrl;
  final double ratingPoint;
  final String description;
  final String snsUrl;

  final bool isDetail;

  const DesignerCard({
    super.key,
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.description,
    required this.snsUrl,
    this.isDetail = false,
  });

  factory DesignerCard.fromModel({
    required DesignerModel model,
    bool isDetail = false,
  }) {
    return DesignerCard(
      id: model.id,
      name: model.name,
      thumbnail: model.thumbnail,
      mainImageUrl: model.mainImageUrl,
      ratingPoint: model.ratingPoint,
      description: model.description,
      snsUrl: model.snsUrl,
      isDetail: isDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.asset(
            mainImageUrl,
            fit: BoxFit.fill,
            width: isDetail ? 100 : 72.0,
            height: isDetail ? 100 : 72.0,
          ),
        ),
        SizedBox(width: isDetail ? 16.0 : 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: isDetail
                    ? MyTextStyle.bigTitleRegular
                    : MyTextStyle.bodyRegular,
              ),
              const SizedBox(height: 4.0),
              Text(
                thumbnail,
                style: isDetail
                    ? MyTextStyle.bodyRegular.copyWith(
                        color: MyColor.darkGrey,
                      )
                    : MyTextStyle.descriptionRegular.copyWith(
                        color: MyColor.darkGrey,
                      ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  PhosphorIcon(
                    PhosphorIcons.star(PhosphorIconsStyle.fill),
                    size: isDetail ? 28.0 : 24.0,
                    color: MyColor.primary,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    ratingPoint.toStringAsFixed(2),
                    style: isDetail
                        ? MyTextStyle.bodyRegular.copyWith(
                            color: MyColor.darkGrey,
                          )
                        : MyTextStyle.descriptionRegular.copyWith(
                            color: MyColor.darkGrey,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
