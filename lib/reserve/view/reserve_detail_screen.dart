import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/component/divider_container.dart';
import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/common/component/show/show_cupertino_alert.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_app_bar.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_layout.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/reserve/component/main_calendar.dart';
import 'package:fall_in_love_with_beauty/reserve/component/reservation_card.dart';
import 'package:fall_in_love_with_beauty/reserve/provider/reserve_provider.dart';
import 'package:fall_in_love_with_beauty/reserve/view/management_reserve_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReserveDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'reserve_detail';

  final String id;

  const ReserveDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ReserveDetailScreen> createState() =>
      _ReserveDetailScreenState();
}

class _ReserveDetailScreenState extends ConsumerState<ReserveDetailScreen> {
  DateTime? reserveDate;

  @override
  Widget build(BuildContext context) {
    final reservation = ref.watch(reserveDetailProvider(widget.id));
    reserveDate ??= reservation.createdAt;

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '예약관리'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
                child: ReservationCard(reservation: reservation),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '예약 일자',
                      style: MyTextStyle.bodyTitleBold,
                    ),
                    Text(
                      DataUtils.convertDateTimeToDateTimeString(
                          datetime: reservation.createdAt),
                      style: MyTextStyle.bodyTitleRegular,
                    ),
                  ],
                ),
              ),
              const DividerContainer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: MainCalendar(
                  selectedDate: reserveDate!,
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    setState(() {
                      reserveDate = selectedDay;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: HorizontalButtonList(
                  buttons: [
                    HorizontalButtonModel(title: '11:00', onTap: () {}),
                    HorizontalButtonModel(title: '12:00', onTap: () {}),
                    HorizontalButtonModel(title: '13:00', onTap: () {}),
                    HorizontalButtonModel(title: '14:00', onTap: () {}),
                    HorizontalButtonModel(title: '15:00', onTap: () {}),
                    HorizontalButtonModel(title: '16:00', onTap: () {}),
                    HorizontalButtonModel(title: '17:00', onTap: () {}),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        onPressed: () {
                          showCustomCupertinoAlert(
                            context: context,
                            titleWidget: Text('예약을 취소하시겠습니까?'),
                            completeText: '예약취소',
                            completeFunction: () {
                              ref
                                  .read(reserveProvider.notifier)
                                  .deleteReservation(id: reservation.id);

                              context
                                  .goNamed(ManagementReserveScreen.routeName);
                            },
                            cancelText: '돌아가기',
                            cancelFunction: () {
                              context.pop();
                            },
                          );
                        },
                        child: const Text('예약 취소'),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () {},
                        child: const Text('예약 변경'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
