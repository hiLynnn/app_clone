import 'package:app_clone/core/constants/app_constants.dart';
import 'package:app_clone/core/constants/color_constants.dart';
import 'package:app_clone/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // StorageService.clearAll();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    try {
      //wait for animations to complete
      await Future.delayed(AppConstants.splashDuration);

      if (!mounted) return;
      final isFirstTime = await StorageService.isFirstTimeUser();
      if (!mounted) return;

      if (isFirstTime) {
        await StorageService.setFirstTimeUser(false);
        if (!mounted) return;
        if (context.mounted) {
          context.pushReplacement('/onboarding');
        }
      } else {
        if (context.mounted) {
          context.pushReplacement('/auth');
        }
      }
    } catch (e) {
      debugPrint('Navigation erro: $e');
      if (mounted) {
        context.pushReplacement('onboarding');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //animated logo container
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.home_rounded,
                      size: 72.w,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 32.h),

            //animated text
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, double value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: Column(
                children: [
                  Text(
                    'HomeRental',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 48.h),

            //loading indicator
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                      strokeWidth: 3,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
