import 'package:app_clone/services/property_service.dart';
import 'package:app_clone/views/search/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_clone/core/common/utils/app_string.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCategory = "매매";
  List<String> selectedTypes = [];
  int? selectedLocationId;

  bool loading = false;

  final GlobalKey locationKey = GlobalKey();

  final List<Map<String, dynamic>> locations = [
    {"id": 4, "key": "location_danang"},
    {"id": 5, "key": "location_hcm"},
    {"id": 6, "key": "location_hanoi"},
  ];

  final List<Map<String, String>> propertyTypes = [
    {"key": "토지", "label_key": "property_land"},
    {"key": "아파트", "label_key": "property_apartment"},
    {"key": "빌라", "label_key": "property_villa"},
    {"key": "오피스텔", "label_key": "property_officetel"},
  ];

  String? selectedLocationLabel;

  @override
  Widget build(BuildContext context) {
    final str = AppString.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(str.search_title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================== LOCATION =====================
            Text(
              str.location,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              key: locationKey,
              onTap: () => _openLocationPicker(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedLocationLabel ?? str.location_placeholder,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ===================== CATEGORY =====================
            Text(
              str.category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                _buildSelectButton("매매", str.category_buy),
                const SizedBox(width: 10),
                _buildSelectButton("임대", str.category_rent),
              ],
            ),

            const SizedBox(height: 25),

            // ===================== TYPES =====================
            Text(
              str.type,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: propertyTypes.map((item) {
                bool checked = selectedTypes.contains(item["key"]);

                return Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Checkbox(
                          value: checked,
                          onChanged: (_) {
                            setState(() {
                              checked
                                  ? selectedTypes.remove(item["key"])
                                  : selectedTypes.add(item["key"]!);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          str.getValue(item["label_key"]!),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // ===================== SEARCH BUTTON =====================
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: loading ? null : _onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1675D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        str.search_button,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================= CATEGORY BUTTON =======================
  Widget _buildSelectButton(String keyLabel, String title) {
    bool active = selectedCategory == keyLabel;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = keyLabel),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: active ? Colors.white : Colors.grey.shade300,
            border: Border.all(color: active ? Colors.black : Colors.grey),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: active ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  // ========================== SEARCH LOGIC ==========================
  void _onSearch() async {
    final str = AppString.of(context);

    if (selectedLocationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(str.select_location_warning)));
      return;
    }

    try {
      final results = await PropertyService.searchProperties(
        status: selectedCategory,
        types: selectedTypes,
        locationId: selectedLocationId,
      );

      if (results.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(str.search_no_result)));
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SearchResultScreen(results: results)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${str.search_failed}: $e")));
    }
  }

  // ========================== LOCATION PICKER ==========================
  void _openLocationPicker() async {
    final str = AppString.of(context);
    final RenderBox box =
        locationKey.currentContext!.findRenderObject() as RenderBox;

    final Offset pos = box.localToGlobal(Offset.zero);
    final Size size = box.size;

    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        pos.dx,
        pos.dy + size.height + 4, // mở NGAY dưới ô Location
        pos.dx + size.width,
        0,
      ),
      items: locations.map((loc) {
        return PopupMenuItem(
          value: loc,
          child: Text(str.getValue(loc["key"]!)),
        );
      }).toList(),
    );

    if (selected != null) {
      setState(() {
        selectedLocationId = selected["id"];
        selectedLocationLabel = str.getValue(selected["key"]!);
      });
    }
  }
}
