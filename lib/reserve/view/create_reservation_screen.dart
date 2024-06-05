import 'package:collection/collection.dart';
import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/component/divider_container.dart';
import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/product/component/designer_card.dart';
import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:fall_in_love_with_beauty/reserve/component/main_calendar.dart';
import 'package:fall_in_love_with_beauty/reserve/model/reservation_model.dart';
import 'package:fall_in_love_with_beauty/reserve/provider/reservation_provider.dart';
import 'package:fall_in_love_with_beauty/reserve/view/select_kind_of_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../product/model/designer_model.dart';

class CreateReservationScreen extends ConsumerStatefulWidget {
  static String get routeName => "create_reserve";

  final String id;

  const CreateReservationScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<CreateReservationScreen> createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState
    extends ConsumerState<CreateReservationScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    1,
  );
  Map<String, String> selectedTime = {};

  void selectedTimeCallBack(
    Map<String, String> selectedTime,
  ) {
    setState(() {
      this.selectedTime = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.read(productDetailProvider(widget.id));

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '예약하기 - 기본'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: MyTextStyle.bigTitleBold,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    product.location,
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: MyColor.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            const DividerContainer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '날짜를 선택해 주세요',
                    style: MyTextStyle.bodyTitleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  MainCalendar(
                    selectedDate: selectedDate,
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                      });
                    },
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
            const DividerContainer(),
            SelectedDesignerTime(
              designers: product.designers,
              selectedTime: selectedTime,
              onChanged: selectedTimeCallBack,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: PrimaryButton(
                onPressed: () {
                  // createdAt
                  final hourAndMinute = selectedTime.values.first
                      .split(':')
                      .map((e) => int.parse(e))
                      .toList();

                  final createdAt = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    hourAndMinute[0],
                    hourAndMinute[1],
                  );

                  // designer
                  final designer = ref.read(
                    designerDetailProvider(selectedTime.keys.first),
                  );

                  final reservationId = DataUtils.getUuid();

                  ReservationModel reservation = ReservationModel(
                    id: reservationId,
                    product: product,
                    designer: designer,
                    result: '',
                    createdAt: createdAt,
                    status: ReservationStatus.ready,
                  );

                  ref
                      .read(reservationProvider.notifier)
                      .addReservation(reservation: reservation);

                  context.goNamed(
                    SelectKindOfResultScreen.routeName,
                    pathParameters: {
                      'id': product.id,
                      'rid': reservationId,
                    },
                  );
                },
                child: const Text('다음'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedDesignerTime extends StatefulWidget {
  final List<DesignerModel> designers;
  final Map<String, String> selectedTime;
  final ValueChanged<Map<String, String>> onChanged;

  const SelectedDesignerTime({
    super.key,
    required this.designers,
    required this.selectedTime,
    required this.onChanged,
  });

  @override
  State<SelectedDesignerTime> createState() => _SelectedDesignerTimeState();
}

class _SelectedDesignerTimeState extends State<SelectedDesignerTime> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          child: Text(
            '디자이너를 선택해 주세요',
            style: MyTextStyle.bodyTitleMedium,
          ),
        ),
        const SizedBox(height: 12.0),
        ...widget.designers.mapIndexed(
          (index, element) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: DesignerCard.fromModel(model: element),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 43.0,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, idx) {
                      final time = getTimeList()[idx];
                      final isSelected =
                          widget.selectedTime.containsKey(element.id) &&
                              widget.selectedTime.containsValue(time);

                      return InkWell(
                        onTap: () {
                          widget.onChanged({element.id: time});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? MyColor.primary : MyColor.white,
                            border: Border.all(
                              width: 1.0,
                              color: MyColor.middleGrey,
                            ),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              time,
                              style: MyTextStyle.bodyRegular.copyWith(
                                color:
                                    isSelected ? MyColor.white : MyColor.text,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(width: 8.0);
                    },
                    itemCount: getTimeList().length,
                  ),
                ),
                if (index != widget.designers.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Divider(
                      height: 24.0,
                      color: MyColor.middleGrey,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  List<String> getTimeList() {
    List<String> returnTimes = [];

    for (int i = 11; i < 21; i++) {
      returnTimes.addAll(["${i}:00", "${i}:30"]);
    }

    return returnTimes;
  }
}
