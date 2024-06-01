import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../home/view/home_screen.dart';
import '../const/colors.dart';
import '../const/text_styles.dart';
import '../layout/default_layout.dart';
import 'error_screen.dart';

class RootTab extends StatelessWidget {
  static String get routeName => 'home';

  final Widget child;

  const RootTab({
    super.key,
    required this.child,
  });

  int getIndex(BuildContext context) {
    switch (GoRouterState.of(context).location) {
      case '/home':
        return 0;
      case '/mall':
        return 1;
      case '/product':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: MyColor.white,
        selectedItemColor: MyColor.text,
        selectedLabelStyle: MyTextStyle.bodyBold.copyWith(fontSize: 12.0),
        unselectedItemColor: MyColor.middleGrey,
        unselectedFontSize: 12.0,
        unselectedLabelStyle: MyTextStyle.bodyBold.copyWith(fontSize: 12.0),
        type: BottomNavigationBarType.fixed,
        currentIndex: getIndex(context),
        onTap: (int index) {
          switch (index) {
            case 0:
              context.goNamed(HomeScreen.routeName);
            case 1:
              context.goNamed(HomeScreen.routeName);
            case 2:
              context.goNamed(HomeScreen.routeName);
            case 3:
              context.goNamed(HomeScreen.routeName);
            default:
              context.goNamed(ErrorScreen.routeName);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIcons.house(),
              size: 30.0,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIcons.storefront(),
              size: 30.0,
            ),
            label: '도매몰',
          ),
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIcons.shoppingBagOpen(),
              size: 30.0,
            ),
            label: '상품',
          ),
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIcons.user(),
              size: 30.0,
            ),
            label: '내 정보',
          ),
        ],
      ),
      child: child,
    );
  }
}
