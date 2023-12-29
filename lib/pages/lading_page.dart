import 'package:flutter/material.dart';
import 'package:my_english_card_app/pages/home_page.dart';
import 'package:my_english_card_app/values/app_colors.dart';
import 'package:my_english_card_app/values/app_images.dart';
import 'package:my_english_card_app/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Welcome to', style: AppStyles.h3),
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'English',
                    style: AppStyles.h2.copyWith(
                        color: AppColors.greyText, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'Qoutes"',
                      textAlign: TextAlign.right,
                      style: AppStyles.h4.copyWith(height: 0.3),
                    ),
                  ),
                ],
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false);
                  },
                  fillColor: AppColors.lightBlue,
                  shape: const CircleBorder(),
                  child: Image.asset(AppImages.rightArrow),
                ),
              )),
            ],
          ),
        ));
  }
}
