import 'package:flutter/material.dart';
import 'package:thingstodo/view/HomePage.dart';
import 'package:thingstodo/view/SplashPage.dart';
import 'package:thingstodo/view/TaskPage.dart';

class RouterOfApp {
  static MaterialPageRoute genRouters(setting) {
    switch (setting.name) {
      case SplashPage.routes:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case HomePage.routes:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case TaskPage.routes:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(title: const Text("Error"), centerTitle: true)));
    }
  }
}
