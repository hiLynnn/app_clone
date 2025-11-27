import 'package:app_clone/core/constants/color_constants.dart';
import 'package:app_clone/models/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  const OnboardingPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Image.asset(content.image, height: 300.h, fit: BoxFit.contain),
            SizedBox(height: 60.h),
            Text(
              content.title,
              style: TextStyle(
                color: AppColors.surface,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                content.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.surface.withOpacity(0.8),
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
