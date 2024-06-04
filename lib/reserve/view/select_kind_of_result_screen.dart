import 'package:collection/collection.dart';
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

class SelectKindOfResultScreen extends StatefulWidget {
  static String get routeName => 'select_kind';

  const SelectKindOfResultScreen({super.key});

  @override
  State<SelectKindOfResultScreen> createState() =>
      _SelectKindOfResultScreenState();
}

class _SelectKindOfResultScreenState extends State<SelectKindOfResultScreen> {
  final Map<String, Map<String, int>> kindOfResult = {
    '커트': {
      '디자인컷 + 두피스케일링': 90000,
      '남자 인생 커트': 20000,
      '여자 인생 커트': 30000,
      '디자인 컷 + 앞머리펌': 40000,
      '커트 + 뿌리볼륨펌': 50000,
      '커트 + 옆머리다운펌': 45000,
      '커트 + 옆,뒷머리다운펌': 55000
    },
    '펌': {
      '남성컷 + 다운펌': 45000,
      '뿌리 볼륨펌': 60000,
      'C컬펌': 80000,
      '히피펌': 80000,
      '셋팅열펌': 90000
    },
    '염색': {
      '전체염색 + 트리트먼트': 120000,
      '뿌리염색 + 커트': 90000,
      '뿌리탈색': 80000,
      '복구염색': 92000,
      '리터치': 77000
    },
    '클리닉': {'베이직케어': 30000, '클래식케어': 34000, '스폐셜큐어': 47000, '프리미엄 헤드스파': 66000},
    '스타일링': {
      '자신감 넘치는 남자 스타일링': 30000,
      '아이롱 드라이': 45000,
      '브로우 드라이': 66000,
      '붙임머리': 54000,
      '릴렉싱샴푸': 24000
    },
  };

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
