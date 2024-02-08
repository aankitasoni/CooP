import 'package:coop/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';
import '../models/onboard.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    final list = [
      Onboard(
        title: 'Ask me Anything',
        subtitle:
            'I can be your Best Friend & You can ask me anything & I will help you!',
        lottie: 'ai_ask_me',
      ),
      Onboard(
        title: 'Imagination to Reality',
        lottie: 'ai_play',
        subtitle:
            'Just Imagine anything & let me know, I will create something wonderful for you!',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          final isLast = index == list.length - 1;

          return Column(
            children: [
              Lottie.asset(
                'assets/lottie/${list[index].lottie}.json',
                height: mq.height * .6,
                width: isLast ? mq.width * .7 : null,
              ),
              Text(
                list[index].title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: mq.height * .015),
              SizedBox(
                width: mq.width * .7,
                child: Text(
                  list[index].subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5,
                    color: Theme.of(context).lightTextColor,
                  ),
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 10,
                children: List.generate(
                  list.length,
                  (i) => Container(
                    width: i == index ? 15 : 10,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == index ? Colors.blue : Colors.grey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  if (isLast) {
                    Get.off(() => const HomeScreen());
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.ease,
                    );
                  }
                },
                text: isLast ? 'Finish' : 'Next',
              ),
              const Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }
}
