import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_app_bar.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_layout.dart';
import 'package:fall_in_love_with_beauty/reserve/model/reserve_model.dart';
import 'package:fall_in_love_with_beauty/reserve/provider/reserve_provider.dart';
import 'package:fall_in_love_with_beauty/reserve/view/reserve_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../common/component/divider_container.dart';
import '../../common/utils/data_utils.dart';
import '../component/reservation_card.dart';

class ManagementReserveScreen extends ConsumerWidget {
  static String get routeName => 'management_reserve';

  const ManagementReserveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservations = ref.watch(reserveProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '예약관리'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
              child: Text(
                '총 ${reservations.length}건',
                style: MyTextStyle.bodyTitleMedium,
              ),
            ),
            Expanded(
              child: CustomGroupedListView(
                reservations: reservations,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGroupedListView extends ConsumerWidget {
  final List<ReserveModel> reservations;

  const CustomGroupedListView({
    super.key,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GroupedListView<ReserveModel, String>(
        physics: const BouncingScrollPhysics(),
        elements: reservations,
        groupBy: (element) => DataUtils.convertDateTimeToDateTimeString(
          datetime: element.createdAt,
        ),
        groupSeparatorBuilder: (String groupByValue) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                groupByValue,
                style: MyTextStyle.bodyRegular,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        itemBuilder: (context, ReserveModel element) {
          return InkWell(
            onTap: () {
              context.pushNamed(
                ReserveDetailScreen.routeName,
                pathParameters: {'id': element.id},
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(
                    height: 1.0,
                    color: MyColor.middleGrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: ReservationCard(
                      reservation: element,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemComparator: (item1, item2) => item1.createdAt.compareTo(
          item2.createdAt,
        ),
        order: GroupedListOrder.DESC,
      ),
    );
  }
}
