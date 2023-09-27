import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:thingstodo/provider/FirebaseFun.dart';
import 'package:thingstodo/routes/Routers.dart';
import 'package:thingstodo/utils/Colors.dart';
import 'package:thingstodo/view/SplashPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => FireBaseFunctions()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouterOfApp.genRouters,
            title: 'Things To Do',
            theme: ThemeData(
              scaffoldBackgroundColor: primaryColor,
              appBarTheme: const AppBarTheme(color: primaryColor),
              useMaterial3: true,
            ),
            home: const SplashPage(),
          ),
        );
      },
    );
  }
}
