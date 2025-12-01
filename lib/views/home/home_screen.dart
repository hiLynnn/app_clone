import 'package:app_clone/core/common/utils/app_string.dart';
import 'package:app_clone/core/constants/color_constants.dart';
import 'package:app_clone/core/constants/text_constants.dart';
import 'package:app_clone/views/home/widgets/banner_carousel.dart';
import 'package:app_clone/views/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.of(context).findYourHome,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              AppTexts.searchHint,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                // child: BannerCarousel(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
