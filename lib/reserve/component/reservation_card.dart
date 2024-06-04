import 'package:flutter/material.dart';

import '../../common/const/text_styles.dart';
import '../model/reservation_model.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;

  const ReservationCard({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.asset(
            reservation.designer.mainImageUrl,
            height: 72.0,
            width: 72.0,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${reservation.product.name} / ${reservation.designer.name}',
                style: MyTextStyle.bodyBold,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                '예약완료 / 러블리 디지털, 셋팅펌',
                style: MyTextStyle.bodyRegular,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
