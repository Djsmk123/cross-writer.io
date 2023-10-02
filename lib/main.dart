// ignore_for_file: depend_on_referenced_packages

import 'package:blogtools/core/themes/theme.dart';
import 'package:blogtools/repo/models/api_keys.dart';
import 'package:blogtools/routing/routing_dat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogApiBoxAdapter());
  runApp(const MyApp());
}

//....................................APP Router  ................................
final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(380, 720),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Cross-writer',
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          theme: CustomTheme.themeData,
        );
      },
    );
  }
}
