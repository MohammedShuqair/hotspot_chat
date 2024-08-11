import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotspot_chat/controllers/network_controller.dart';
import 'package:hotspot_chat/data_sources/database/tables/data_base_helper.dart';
import 'package:hotspot_chat/data_sources/shared_pref/shared_helper.dart';
import 'package:hotspot_chat/services/navigation_service/navigation_service.dart';
import 'package:hotspot_chat/utils/colors.dart';
import 'package:hotspot_chat/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DatabaseHelper.instance.database;
  await SharedHelper.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NetworkController(),
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: "Hotspot Chat",
              navigatorKey: NavigationService.navigatorKey,
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: true,
              ),
              home: SplashScreen(),
            );
          }),
    );
  }
}
