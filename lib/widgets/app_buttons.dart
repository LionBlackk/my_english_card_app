import 'package:flutter/material.dart';
import 'package:my_english_card_app/values/app_colors.dart';
import 'package:my_english_card_app/values/app_styles.dart';

class AppButons extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const AppButons({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(3, 4),
                blurRadius: 3,
              ),
            ]),
        child: Column(
          children: [
            Text(label,
                style: AppStyles.h5.copyWith(
                    color: AppColors.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
