import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/component/horizontal_button_list.dart';
import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_app_bar.dart';
import 'package:fall_in_love_with_beauty/common/layout/default_layout.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/common/view/completion_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectKindOfResultScreen extends StatelessWidget {
  static String get routeName => 'select_kind';

  const SelectKindOfResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(title: '예약하기 - 시술'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
              child: Text(
                '배기훈님 어떤 시술을 원하시나요?',
                style: MyTextStyle.bodyTitleMedium,
              ),
            ),
            HorizontalButtonList(
              buttons: [
                HorizontalButtonModel(
                  title: '커트',
                  onTap: () {},
                ),
                HorizontalButtonModel(
                  title: '펌',
                  onTap: () {},
                ),
                HorizontalButtonModel(
                  title: '염색',
                  onTap: () {},
                ),
                HorizontalButtonModel(
                  title: '클리닉',
                  onTap: () {},
                ),
                HorizontalButtonModel(
                  title: '스타일링',
                  onTap: () {},
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 20.0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: TitleAndPrice(
                      title: '남성컷 + 다운펌',
                      price: 600000,
                      isSelected: true,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 24.0,
                    color: MyColor.middleGrey,
                  );
                },
                itemCount: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PrimaryButton(
                onPressed: () {
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
