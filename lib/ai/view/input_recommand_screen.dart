import 'package:fall_in_love_with_beauty/common/component/custom_ink_well_button.dart';
import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/common/const/image_path.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/component/default_button.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class InputRecommendScreen extends StatefulWidget {
  static String get routeName => "input_recommend";

  const InputRecommendScreen({super.key});

  @override
  State<InputRecommendScreen> createState() => _InputRecommendScreenState();
}

class _InputRecommendScreenState extends State<InputRecommendScreen> {
  final ScrollController scrollController = ScrollController();

  String first = '';
  bool isAnswerFirst = false;
  String second = '';
  bool isAnswerSecond = false;
  String third = '';
  bool isAnswerThird = false;
  String fourth = '';
  bool isAnswerFourth = false;

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: 'AI 추천 뷰티'),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderQuestion(
                title: '어떤 관리를 받고 싶으신가요?',
                titleOfButton: ['미용', '네일', '왁싱', '눈썹'],
                selectedTitleOfButton: first,
                onChanged: (String value) {
                  setState(() {
                    first = value;
                    isAnswerFirst = true;
                    _scrollToBottom();
                  });
                },
                isAnswer: true,
              ),
              _renderAnswer(title: first, isAnswer: isAnswerFirst),
              _renderQuestion(
                title: '어떤 시술을 원하세요?',
                titleOfButton: ['커트', '펌', '염색', '클리닉'],
                selectedTitleOfButton: second,
                onChanged: (String value) {
                  setState(() {
                    second = value;
                    isAnswerSecond = true;
                    _scrollToBottom();
                  });
                },
                isAnswer: isAnswerFirst,
              ),
              _renderAnswer(title: second, isAnswer: isAnswerSecond),
              _renderQuestion(
                title: '상세 시술을 선택해 주세요.',
                titleOfButton: ['열펌', '디지털 펌', '셋팅펌'],
                selectedTitleOfButton: third,
                onChanged: (String value) {
                  setState(() {
                    third = value;
                    isAnswerThird = true;
                    _scrollToBottom();
                  });
                },
                isAnswer: isAnswerSecond,
              ),
              _renderAnswer(title: third, isAnswer: isAnswerThird),
              _renderQuestion(
                title: '행사 여부를 선택해 주세요.',
                titleOfButton: ['네', '아니요'],
                selectedTitleOfButton: fourth,
                onChanged: (String value) async {
                  setState(() {
                    fourth = value;
                    isAnswerFourth = true;
                    _scrollToBottom();
                  });
                },
                isAnswer: isAnswerThird,
              ),
              _renderAnswer(title: fourth, isAnswer: isAnswerFourth),
              _renderQuestion(
                title: '네! 감사합니다.\n고객님 인근지역 디지털펌을\n잘하는 샵을 추천해 드릴께요!',
                titleOfButton: [],
                selectedTitleOfButton: fourth,
                onChanged: (String value) {},
                isAnswer: isAnswerFourth,
              ),
              if (isAnswerFirst &&
                  isAnswerSecond &&
                  isAnswerThird &&
                  isAnswerFourth)
                PrimaryButton(
                  onPressed: () {},
                  child: const Text('확인하기'),
                ),
              AnimatedContainer(
                height: !(isAnswerFirst &&
                        isAnswerSecond &&
                        isAnswerThird &&
                        isAnswerFourth)
                    ? 300
                    : 0,
                duration: const Duration(seconds: 2),
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderQuestion({
    required String title,
    required List<String> titleOfButton,
    required String selectedTitleOfButton,
    required ValueChanged<String> onChanged,
    required bool isAnswer,
  }) {
    return AnimatedContainer(
      height: isAnswer ? 160 : 0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: MyColor.middleGrey),
                      borderRadius: BorderRadius.circular(100.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset(
                      ImagePath.ai,
                      height: 40.0,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  decoration: const BoxDecoration(
                    color: MyColor.lightGrey,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      title,
                      style: MyTextStyle.bodyRegular,
                    ),
                  ),
                ),
              ],
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
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _renderAnswer({required String title, required bool isAnswer}) {
    return AnimatedContainer(
      height: isAnswer ? 48 : 0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: MyColor.lightGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                title,
                style: MyTextStyle.bodyRegular,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: MyColor.middleGrey),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                ImagePath.user,
                height: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
