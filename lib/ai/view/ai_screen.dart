import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class AIScreen extends ConsumerWidget {
  static String get routeName => "ai";

  const AIScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: 'AI 추천'),
      child: Column(
        children: [
          Text('ai'),
        ],
      ),
    );
  }
}
