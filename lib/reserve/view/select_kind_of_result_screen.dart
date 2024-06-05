import 'package:collection/collection.dart';
import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_app_bar.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_layout.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/common/view/completion_screen.dart';
import 'package:fall_in_love_with_beauty/reserve/provider/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/data.dart';

class SelectKindOfResultScreen extends ConsumerStatefulWidget {
  static String get routeName => 'select_kind';

  final String rid;

  const SelectKindOfResultScreen({
    super.key,
    required this.rid,
  });

  @override
  ConsumerState<SelectKindOfResultScreen> createState() =>
      _SelectKindOfResultScreenState();
}

class _SelectKindOfResultScreenState
    extends ConsumerState<SelectKindOfResultScreen> {
  String selectedKey = '커트';
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: '예약하기 - 시술'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24.0, bottom: 20.0),
              child: Text(
                '배기훈님 어떤 시술을 원하시나요?',
                style: MyTextStyle.bodyTitleMedium,
              ),
            ),
            HorizontalButtonList(
              buttons: [
                ...kindOfResult.keys.mapIndexed(
                  (index, element) => HorizontalButtonModel(
                    title: element,
                    onTap: () {
                      setState(() {
                        selectedKey = element;
                      });
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 20.0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final title = kindOfResult[selectedKey]!.keys.toList()[index];
                  final price =
                      kindOfResult[selectedKey]!.values.toList()[index];

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedValue = title;
                      });
                    },
                    child: TitleAndPrice(
                      title: title,
                      price: price,
                      isSelected: selectedValue == title,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 24.0,
                    color: MyColor.middleGrey,
                  );
                },
                itemCount: kindOfResult[selectedKey]!.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PrimaryButton(
                onPressed: () {
                  ref
                      .read(reservationProvider.notifier)
                      .updateReservationResult(
                        id: widget.rid,
                        result: selectedValue,
                      );

                  context.goNamed(
                    CompletionScreen.routeName,
                    pathParameters: {'title': "예약이\n정상적으로\n완료되었습니다."},
                  );
                },
                child: const Text('예약하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAndPrice extends StatelessWidget {
  final String title;
  final int price;
  final bool isSelected;

  const TitleAndPrice({
    super.key,
    required this.title,
    required this.price,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhosphorIcon(
            isSelected
                ? PhosphorIcons.radioButton(PhosphorIconsStyle.fill)
                : PhosphorIcons.radioButton(),
            size: 24.0,
            color: isSelected ? MyColor.primary : MyColor.text,
          ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: MyTextStyle.bodyRegular,
              ),
              const SizedBox(height: 4.0),
              Text(
                DataUtils.convertPriceToMoneyString(price: price),
                style: MyTextStyle.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
