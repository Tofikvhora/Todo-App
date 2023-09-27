import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thingstodo/utils/StringNavigation.dart';
import 'package:thingstodo/view/HomePage.dart';

class SplashPage extends HookWidget {
  static const String routes = "SplashPage";
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 3), () {
        HomePage.routes.pushAndReplace(context);
      });
    }, []);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset("asset/images/firstImage.png")),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Image.asset(
              "asset/images/Hourglass-unscreen.gif",
            ),
          ),
        ],
      ),
    );
  }
}
