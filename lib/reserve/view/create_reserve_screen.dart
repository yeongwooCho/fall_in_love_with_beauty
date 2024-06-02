import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class CreateReserveScreen extends ConsumerStatefulWidget {
  static String get routeName => "create_reserve";

  final String id;

  const CreateReserveScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<CreateReserveScreen> createState() =>
      _CreateReserveScreenState();
}

class _CreateReserveScreenState extends ConsumerState<CreateReserveScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ref.read(productDetailProvider(widget.id));

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '예약하기 - 기본'),
      child: Column(
        children: [
          Text('asfd'),
        ],
      ),
    );
  }
}
