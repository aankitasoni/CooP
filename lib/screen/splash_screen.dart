import 'package:coop/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db/pref.dart';
import '../helper/global.dart';
import '../widgets/custom_loading.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //?? init ->
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Get.off(
          () => Pref.showOnboarding
              ? const OnboardingScreen()
              : const HomeScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //*** Media Query ->
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            const Spacer(flex: 2),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(mq.width * .05),
                child:
                    Image.asset('assets/images/logo.png', width: mq.width * .4),
              ),
            ),
            const Spacer(),
            const CustomLoading(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
