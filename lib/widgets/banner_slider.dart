import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  final Size size;
  const BannerSlider({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final bannerImages = [
      "assets/images/banner-1.webp",
      "assets/images/banner-2.webp",
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: size.width * 0.48,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: false,
      ),
      items: bannerImages.map((img) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(img, width: size.width, fit: BoxFit.cover),
        );
      }).toList(),
    );
  }
}
