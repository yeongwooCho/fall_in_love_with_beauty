import 'package:fall_in_love_with_beauty/ai/view/input_recommand_screen.dart';
import 'package:fall_in_love_with_beauty/common/component/default_button.dart';
import 'package:fall_in_love_with_beauty/common/const/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class AIScreen extends ConsumerWidget {
  static String get routeName => "ai";

  const AIScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: 'AI 추천'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: PrimaryButton(
          onPressed: () {
            context.goNamed(InputRecommendScreen.routeName);
          },
          child: const Text('뷰티샵 추천 받기'),
        ),
      ),
      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60.0),
            Text(
              '안녕하세요!',
              style: MyTextStyle.headTitle,
            ),
            SizedBox(height: 8.0),
            Text(
              "'뷰티에 반하다' 몇가지 질문을 통해 고객님께 뷰티샵을 추천해 드려요!",
              style: MyTextStyle.bigTitleRegular,
            ),
          ],
        ),
      ),
    );
  }
}
