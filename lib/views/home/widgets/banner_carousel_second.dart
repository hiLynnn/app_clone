import 'package:app_clone/controllers/home_controller.dart';
import 'package:app_clone/models/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BannerCarouselSecond extends StatelessWidget {
  BannerCarouselSecond({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isBannerLoading.value) {
        return SizedBox(
          height: 100.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.secondBanners.isEmpty) {
        return SizedBox(
          height: 100.h,
          child: const Center(child: Text("No Second Banners available")),
        );
      }

      return CarouselSlider(
        items: controller.secondBanners.map((BannerModel banner) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: banner.imagePath,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 100.h,
          viewportFraction: 0.9,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      );
    });
  }
}
