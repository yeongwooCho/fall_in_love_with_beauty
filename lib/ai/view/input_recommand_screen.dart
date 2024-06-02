import 'package:fall_in_love_with_beauty/common/component/custom_ink_well_button.dart';
import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:flutter/material.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class InputRecommendScreen extends StatefulWidget {
  static String get routeName => "input_recommend";

  const InputRecommendScreen({super.key});

  @override
  State<InputRecommendScreen> createState() => _InputRecommendScreenState();
}

class _InputRecommendScreenState extends State<InputRecommendScreen> {
  String first = '';
  String second = '';
  String third = '';
  String fourth = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: 'AI 추천 뷰티'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderButtonList(
                title: '어떤 관리를 받고 싶으신가요?',
                titleOfButton: ['미용', '네일', '왁싱', '눈썹'],
                selectedTitleOfButton: first,
                onChanged: (String value) {
                  print(value);
                  setState(() {
                    first = value;
                  });
                },
              ),
              _renderButtonList(
                title: '어떤 시술을 원하세요?',
                titleOfButton: ['커트', '펌', '염색', '클리닉'],
                selectedTitleOfButton: second,
                onChanged: (String value) {
                  setState(() {
                    second = value;
                  });
                },
              ),
              _renderButtonList(
                title: '상세 시술을 선택해 주세요.',
                titleOfButton: ['열펌', '디지털 펌', '셋팅펌'],
                selectedTitleOfButton: third,
                onChanged: (String value) {
                  setState(() {
                    third = value;
                  });
                },
              ),
              _renderButtonList(
                title: '행사 여부를 선택해 주세요.',
                titleOfButton: ['네', '아니요'],
                selectedTitleOfButton: fourth,
                onChanged: (String value) {
                  setState(() {
                    fourth = value;
                  });
                },
              ),
              const Text(
                '네! 감사합니다.\n고객님 인근지역 디지털펌을 잘하는 샵을 추천해 드릴께요!',
                style: MyTextStyle.bodyTitleMedium,
              ),
              const SizedBox(height: 40.0),
              PrimaryButton(
                onPressed: () {},
                child: const Text('확인하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderButtonList({
    required String title,
    required List<String> titleOfButton,
    required String selectedTitleOfButton,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: MyTextStyle.bodyTitleMedium,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: [
            ...titleOfButton.map(
              (e) => CustomInkWellButton(
                title: e,
                onTap: () {
                  onChanged(e);
                },
                isSelected: selectedTitleOfButton == e,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40.0),
      ],
    );
  }
}
