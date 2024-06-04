import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:fall_in_love_with_beauty/reserve/view/create_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultModalBottomSheet extends StatelessWidget {
  final String productId;
  final DesignerModel designer;
  final String resultImageUrl;

  const ResultModalBottomSheet({
    super.key,
    required this.productId,
    required this.designer,
    required this.resultImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 525.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset(
                      designer.mainImageUrl,
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        designer.name,
                        style: MyTextStyle.bodyRegular,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        designer.thumbnail,
                        style: MyTextStyle.descriptionRegular.copyWith(
                          color: MyColor.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  SecondaryButton(
                    onPressed: () {
                      context.pushNamed(
                        CreateReservationScreen.routeName,
                        pathParameters: {"id": productId},
                      );
                    },
                    child: const Text('예약하기'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Image.asset(
                resultImageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
