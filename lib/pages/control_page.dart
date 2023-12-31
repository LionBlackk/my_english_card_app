import 'package:flutter/material.dart';
import 'package:my_english_card_app/values/app_colors.dart';
import 'package:my_english_card_app/values/app_images.dart';
import 'package:my_english_card_app/values/app_styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text('Your control',
            style: AppStyles.h3
                .copyWith(color: AppColors.textColor, fontSize: 38)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppImages.leftArrow),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              Text('How much a number word at once',
                  style: AppStyles.h5
                      .copyWith(color: AppColors.lightGrey, fontSize: 18)),
              const Spacer(),
              Text('${sliderValue.toInt()}',
                  style: AppStyles.h1.copyWith(
                      fontSize: 150,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold)),
              Slider(
                  value: sliderValue,
                  min: 5,
                  max: 100,
                  divisions: 95,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  }),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text('slide to set',
                    style: AppStyles.h5.copyWith(color: AppColors.textColor)),
              ),
              const Spacer(),
              const Spacer(),
              const Spacer(),
            ],
          )),
    );
  }
}
