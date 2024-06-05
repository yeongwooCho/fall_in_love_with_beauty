import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/component/divider_container.dart';
import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/common/component/show/show_cupertino_alert.dart';
import 'package:fall_in_love_with_beauty/common/component/show/show_custom_toast.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_app_bar.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_layout.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/reserve/component/main_calendar.dart';
import 'package:fall_in_love_with_beauty/reserve/component/reservation_card.dart';
import 'package:fall_in_love_with_beauty/reserve/provider/reservation_provider.dart';
import 'package:fall_in_love_with_beauty/reserve/view/management_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReservationDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'reserve_detail';

  final String id;

  const ReservationDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ReservationDetailScreen> createState() =>
      _ReservationDetailScreenState();
}

class _ReservationDetailScreenState
    extends ConsumerState<ReservationDetailScreen> {
  DateTime? reserveDate;
  Duration selectedTime = Duration(hours: 11);

  @override
  Widget build(BuildContext context) {
    final reservation = ref.watch(reservationDetailProvider(widget.id));
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
                    ...[11, 12, 13, 14, 15, 16, 17, 18, 19, 20].map(
                      (e) => HorizontalButtonModel(
                          title: '$e:00',
                          onTap: () {
                            selectedTime = Duration(hours: e);
                          }),
                    ),
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
                                  .read(reservationProvider.notifier)
                                  .deleteReservation(id: reservation.id);

                              context.goNamed(
                                  ManagementReservationScreen.routeName);

                              showCustomToast(context, msg: '예약이 취소되었습니다.');
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
                        onPressed: () {
                          if (reserveDate != null) {
                            showCustomCupertinoAlert(
                              context: context,
                              titleWidget: Text('예약을 변경하시겠습니까?'),
                              completeText: '변경하기',
                              completeFunction: () {
                                final createdAt =
                                    reserveDate!.add(selectedTime);
                                ref
                                    .read(reservationProvider.notifier)
                                    .updateCreatedAt(
                                      id: widget.id,
                                      createdAt: createdAt,
                                    );
                                context.goNamed(
                                    ManagementReservationScreen.routeName);

                                showCustomToast(context, msg: '예약이 변경되었습니다.');
                              },
                              cancelText: '돌아가기',
                              cancelFunction: () {
                                context.pop();
                              },
                            );
                          } else {
                            print(reserveDate);
                            print(selectedTime);
                          }
                        },
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
