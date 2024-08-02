import 'package:flutter/material.dart';
import 'package:task_wave/core/routes/app_routes.dart';
import 'package:task_wave/core/util/constants/app_image.dart';
import 'package:task_wave/core/util/helper_functions/helper_functions.dart';
import 'package:task_wave/core/util/services/shared_preference_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navToNextScreen();

    super.initState();
  }

  _navToNextScreen() {
    bool isFirstTime = SharedPreferencesService.instance!.isFirstTime!;
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      if (isFirstTime) {
        replacePage(context, AppRoutes.onBoardingRoute);
      } else {
        replacePage(context, AppRoutes.homeRoute);
      }
    });
  }

  buildBody() {
    return Center(
      child: Image.asset(AppImages.appIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 246, 237, 1),
      body: buildBody(),
    );
  }
}
