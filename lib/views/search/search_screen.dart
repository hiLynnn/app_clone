import 'package:app_clone/services/property_service.dart';
import 'package:app_clone/views/search/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCategory = "매매"; // 매매 = bán, 임대 = cho thuê
  List<String> selectedTypes = [];
  int? selectedLocationId;

  bool loading = false;

  final List<Map<String, dynamic>> locations = [
    {"id": 4, "name": "다낭"},
    {"id": 5, "name": "호치민"},
    {"id": 6, "name": "하노이"},
  ];

  final List<Map<String, String>> propertyTypes = [
    {"key": "토지", "label": "토지"},
    {"key": "아파트", "label": "아파트"},
    {"key": "빌라", "label": "빌라"},
    {"key": "오피스텔", "label": "오피스텔"},
  ];

  String? selectedLocationLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("검색하기"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================== LOCATION =====================
            const Text(
              "위치",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () => _openLocationPicker(context),
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
                      selectedLocationLabel ?? "하노이, 호치민, 다낭 등 선택",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ===================== CATEGORY (매매/임대) =====================
            const Text(
              "구분",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                _buildSelectButton("매매"),
                const SizedBox(width: 10),
                _buildSelectButton("임대"),
              ],
            ),

            const SizedBox(height: 25),

            // ===================== TYPES =====================
            const Text(
              "형태",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: propertyTypes.map((item) {
                bool checked = selectedTypes.contains(item["key"]);

                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Checkbox(
                          value: checked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          onChanged: (_) {
                            setState(() {
                              checked
                                  ? selectedTypes.remove(item["key"])
                                  : selectedTypes.add(item["key"]!);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 4), // thu nhỏ spacing
                      Flexible(
                        child: Text(
                          item["label"]!,
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
                    : const Text(
                        "검색하기",
                        style: TextStyle(
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

  // ======================= CATEGORY (매매/임대) BUTTON =======================
  Widget _buildSelectButton(String label) {
    bool active = selectedCategory == label;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = label),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: active ? Colors.white : Colors.grey.shade300,
            border: Border.all(color: active ? Colors.black : Colors.grey),
          ),
          child: Text(
            label,
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
    if (selectedLocationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("위치를 선택하세요.")));
      return;
    }

    try {
      final results = await PropertyService.searchProperties(
        status: selectedCategory,
        types: selectedTypes,
        locationId: selectedLocationId,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SearchResultScreen(results: results)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("검색 실패: $e")));
    }
  }

  // ========================== LOCATION PICKER ==========================
  void _openLocationPicker(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: locations.map((loc) {
          return ListTile(
            title: Text(loc["name"]),
            onTap: () {
              setState(() {
                selectedLocationId = loc["id"];
                selectedLocationLabel = loc["name"];
              });
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      ),
    );
  }
}
