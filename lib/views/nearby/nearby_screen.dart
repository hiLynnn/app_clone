import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  late GoogleMapController mapController;

  final LatLng center = const LatLng(10.794, 106.699); // HCM City fake

  final List<Map<String, dynamic>> demoProperties = [
    {
      "name": "Nhà đẹp Quận 1",
      "price": "12 tỷ",
      "location": "Quận 1",
      "lat": 10.7758,
      "lng": 106.7004,
      "image": "https://picsum.photos/300/200?1",
    },
    {
      "name": "Căn hộ Thủ Đức",
      "price": "2.3 tỷ",
      "location": "Thủ Đức",
      "lat": 10.8494,
      "lng": 106.7547,
      "image": "https://picsum.photos/300/200?2",
    },
    {
      "name": "Căn hộ Thủ Đức",
      "price": "2.3 tỷ",
      "location": "Thủ Đức",
      "lat": 10.8494,
      "lng": 106.7547,
      "image": "https://picsum.photos/300/200?2",
    },
    {
      "name": "Căn hộ Thủ Đức",
      "price": "2.3 tỷ",
      "location": "Thủ Đức",
      "lat": 10.8494,
      "lng": 106.7547,
      "image": "https://picsum.photos/300/200?2",
    },
    {
      "name": "Căn hộ Thủ Đức",
      "price": "2.3 tỷ",
      "location": "Thủ Đức",
      "lat": 10.8494,
      "lng": 106.7547,
      "image": "https://picsum.photos/300/200?2",
    },
    {
      "name": "Căn hộ Thủ Đức",
      "price": "2.3 tỷ",
      "location": "Thủ Đức",
      "lat": 10.8494,
      "lng": 106.7547,
      "image": "https://picsum.photos/300/200?2",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterRow(),
          const SizedBox(height: 10),
          // _buildMap(),
          Expanded(child: _buildPropertyList()),
        ],
      ),
    );
  }

  // ---------------- SEARCH BAR ----------------
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search nearby properties...",
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  // ---------------- FILTER ROW ----------------
  Widget _buildFilterRow() {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _filterChip("Apartment"),
          _filterChip("Villa"),
          _filterChip("Officetel"),
          _filterChip("Land"),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(label: Text(label), backgroundColor: Colors.grey.shade100),
    );
  }

  // ---------------- GOOGLE MAP ----------------
  Widget _buildMap() {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: center, zoom: 13),
        markers: {
          for (var p in demoProperties)
            Marker(
              markerId: MarkerId(p["name"]),
              position: LatLng(p["lat"], p["lng"]),
            ),
        },
        onMapCreated: (c) => mapController = c,
      ),
    );
  }

  // ---------------- LIST OF PROPERTIES ----------------
  Widget _buildPropertyList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: demoProperties.length,
      itemBuilder: (context, i) {
        final p = demoProperties[i];
        return _propertyItem(p);
      },
    );
  }

  Widget _propertyItem(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              p["image"],
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p["price"],
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        p["location"],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
