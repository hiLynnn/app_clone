import 'package:app_clone/controllers/home_controller.dart';
import 'package:app_clone/core/common/utils/app_string.dart';
import 'package:app_clone/core/constants/color_constants.dart';
import 'package:app_clone/models/quick_menu_model.dart';
import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/services/property_service.dart';
import 'package:app_clone/views/home/widgets/banner_carousel.dart';
import 'package:app_clone/views/home/widgets/banner_carousel_second.dart';
import 'package:app_clone/views/home/widgets/quick_menu_grid.dart';
import 'package:app_clone/views/home/widgets/home_app_bar.dart';
import 'package:app_clone/views/home/widgets/property_card.dart';
import 'package:app_clone/views/home/widgets/property_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PropertyModel> hotItems = [];
  bool loadingHot = true;

  @override
  void initState() {
    super.initState();
    loadHot();
  }

  Future<void> loadHot() async {
    final data = await PropertyService.fetchHotProperties();
    setState(() {
      hotItems = data;
      loadingHot = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(),

            // --- Banner ---
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: BannerCarousel(),
              ),
            ),

            // --- Quick Menu ---
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.of(context).quick_menu,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Obx(() {
                      final controller = Get.find<HomeController>();

                      if (controller.isQuickMenuLoading.value) {
                        return SizedBox(
                          height: 120,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return QuickMenuGrid(items: controller.quickMenus);
                    }),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  AppString.of(context).hotPropertiesTitle,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Obx(() {
                final controller = Get.find<HomeController>();

                if (controller.isHotLoading.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.hotProperties.isEmpty) {
                  return Center(child: Text("No data"));
                }

                return PropertyCarouselPager(items: controller.hotProperties);
              }),
            ),

            // --- Second Banner ---
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: BannerCarouselSecond(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
