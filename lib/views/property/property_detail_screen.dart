import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/services/property_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

class PropertyDetailScreen extends StatefulWidget {
  final int propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  PropertyModel? data;
  bool loading = true;

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  // _buildImages(),
                  const SizedBox(height: 10),
                  _buildMainInfo(),
                  const SizedBox(height: 20),
                  _buildOptions(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  const SizedBox(height: 20),
                  // _buildMap(),
                  const SizedBox(height: 20),
                  _buildAgency(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          _bottomActions(),
        ],
      ),
    );
  }

  // ====================== IMAGES ======================
  Widget _buildImages() {
    final images = data!.images;

    return Stack(
      children: [
        images.isNotEmpty
            ? CarouselSlider(
                items: images
                    .map(
                      (img) => Image.network(
                        img.startsWith("http")
                            ? img
                            : "http://42.115.7.129:8080$img", // FIXED
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.error),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 260,
                  viewportFraction: 1,
                  autoPlay: true,
                ),
              )
            : Image.network(
                data!.image,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.error),
              ),
      ],
    );
  }

  // ====================== NAME + PRICE ======================
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

  // ====================== OPTIONS ======================
  Widget _buildOptions() {
    if (data!.options.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 14,
        runSpacing: 10,
        children: data!.options
            .map(
              (opt) => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(opt.name, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(
                      opt.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // ====================== DESCRIPTION ======================
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

  // ====================== MAP ======================
  Widget _buildMap() {
    return SizedBox(
      height: 250,
      child: gmap.GoogleMap(
        initialCameraPosition: gmap.CameraPosition(
          target: gmap.LatLng(data!.lat, data!.lng),
          zoom: 16,
        ),
        markers: {
          gmap.Marker(
            markerId: const gmap.MarkerId("location"),
            position: gmap.LatLng(data!.lat, data!.lng),
          ),
        },
      ),
    );
  }

  // ====================== AGENCY ======================
  Widget _buildAgency() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin môi giới",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(
                    "assets/images/agent_placeholder.png",
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

            const SizedBox(height: 6),
            Text("Số điện thoại: ${data!.agencyPhone}"),
            Text("Địa chỉ: ${data!.agencyAddress}"),
          ],
        ),
      ),
    );
  }

  // ====================== BOTTOM ACTIONS ======================
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
                "Gọi ngay",
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
                "Nhắn tin",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
