import 'package:flutter/material.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/app/router.dart';
import 'package:shop_manager/app/theme.dart';
import 'package:shop_manager/constants/app.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: AppK.debugShowCheckedModeBanner,
      title: AppK.name,
      theme: AppTheme.light,
      initialRoute: Routes.login,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
