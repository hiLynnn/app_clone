import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/services/property_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PropertyDetailScreen extends StatefulWidget {
  final int propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  PropertyModel? data;
  bool loading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    try {
      final res = await PropertyService.fetchPropertyDetail(widget.propertyId);
      setState(() {
        data = res;
        loading = false;
      });
    } catch (e) {
      print("ERROR DETAIL: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (data == null) {
      return const Scaffold(
        body: Center(child: Text("Không tìm thấy thông tin")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          data!.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  /// ================== IMAGES ==================
                  _buildImages(),
                  const SizedBox(height: 20),

                  /// ================== MAIN INFO ==================
                  _buildMainInfo(),
                  const SizedBox(height: 20),

                  /// ================== OPTIONS ==================
                  _buildOptions(),
                  const SizedBox(height: 20),

                  /// ================== DESCRIPTION ==================
                  _buildDescription(),
                  const SizedBox(height: 20),

                  /// ================== AGENCY ==================
                  _buildAgency(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          /// ================== BOTTOM BUTTONS ==================
          _bottomActions(),
        ],
      ),
    );
  }

  // =======================================================
  // SLIDER IMAGES (REUSED FROM HOME BANNER)
  // =======================================================
  Widget _buildImages() {
    final List<String> images = data!.images.isNotEmpty
        ? data!.images
        : [data!.image]; // fallback 1 ảnh

    return Column(
      children: [
        CarouselSlider(
          items: images.map((img) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: img.startsWith("http")
                    ? img
                    : "https://api.sdfsdf.co.kr$img",
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => _bigImageShimmer(),
                errorWidget: (_, __, ___) => _bigImageShimmer(),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 250.h,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, _) => setState(() => currentIndex = index),
          ),
        ),

        const SizedBox(height: 10),

        /// Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: currentIndex == index ? 14 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? Colors.blue
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bigImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 250.h,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  // =======================================================
  // MAIN INFO
  // =======================================================
  Widget _buildMainInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data!.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            data!.price,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.place, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                data!.location,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================================================
  // OPTIONS
  // =======================================================
  Widget _buildOptions() {
    if (data!.options.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        children: data!.options.map((op) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(op.name),
                const SizedBox(width: 6),
                Text(
                  op.value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // =======================================================
  // DESCRIPTION
  // =======================================================
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mô tả",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Html(data: data!.description),
        ],
      ),
    );
  }

  // =======================================================
  // AGENCY
  // =======================================================
  Widget _buildAgency() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin môi giới",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// Avatar
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl: data!.agencyImage,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _avatarShimmer(),
                    errorWidget: (_, __, ___) => _avatarShimmer(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    data!.agencyName.isNotEmpty ? data!.agencyName : "Agent",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text("Số điện thoại: ${data!.agencyPhone}"),
            Text("Địa chỉ: ${data!.agencyAddress}"),
          ],
        ),
      ),
    );
  }

  Widget _avatarShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  // =======================================================
  // BOTTOM BUTTONS
  // =======================================================
  Widget _bottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text(
                "Call",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text(
                "Message",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
