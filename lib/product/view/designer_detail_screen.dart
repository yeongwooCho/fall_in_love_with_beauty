import 'package:fall_in_love_with_beauty/common/const/colors.dart';
import 'package:fall_in_love_with_beauty/product/component/designer_card.dart';
import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class DesignerDetailScreen extends ConsumerWidget {
  static String get routeName => "designer_detail";

  final String id;

  const DesignerDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designer = ref.read(designerDetailProvider(id));

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '디자이너 상세'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignerCard.fromModel(
                model: designer,
                isDetail: true,
              ),
              const SizedBox(height: 40.0),
              Text(
                designer.description,
                style: MyTextStyle.bodyRegular,
              ),
              const SizedBox(height: 40.0),
              Row(
                children: [
                  PhosphorIcon(
                    PhosphorIcons.instagramLogo(),
                    size: 28.0,
                    color: MyColor.primary,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    designer.snsUrl,
                    style: MyTextStyle.descriptionRegular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
