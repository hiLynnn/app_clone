import 'package:app_clone/core/constants/color_constants.dart';
import 'package:app_clone/models/onboarding_content.dart';
import 'package:app_clone/views/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/images/onboarding/onboarding1.png',
      title: 'Find Perfect Home',
      description:
          'Discover your perfect home from our vast collection of properties',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding/onboarding2.png',
      title: 'Easy Booking',
      description: 'Book your desired property with just a few taps',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding/onboarding1.png',
      title: 'Move In Quickly',
      description: 'Quick and hassle-free move-in process for your comfort',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _contents.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return OnboardingPage(content: _contents[index]);
            },
          ),

          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _contents.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: _currentPage == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.surface
                            : AppColors.surface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => context.go('/auth'),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.surface,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 120.w,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage == _contents.length - 1) {
                              context.go('/auth');
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surface,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 16.h,
                            ),
                          ),
                          child: Text(
                            _currentPage == _contents.length - 1
                                ? "Get Started"
                                : "Next",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
