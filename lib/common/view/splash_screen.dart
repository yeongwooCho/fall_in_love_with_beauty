import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../user/view/login_screen.dart';
import '../const/colors.dart';
import '../const/image_path.dart';
import '../layout/default_layout.dart';

class SplashScreen extends StatefulWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    delay();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: MyColor.barrier,
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  ImagePath.appIcon,
                  width: MediaQuery.of(context).size.width * 4 / 7,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              ImagePath.logoBlack,
              width: MediaQuery.of(context).size.width * 3 / 7,
            ),
          ],
        ),
      ),
    );
  }

  void delay() async {
    await Future.delayed(const Duration(seconds: 1));

    context.goNamed(LoginScreen.routeName);
  }
}
