import 'package:app_clone/core/common/utils/app_string.dart';
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
  // ====================== STATES ======================
  String selectedDealType = "매매"; // giữ value Hàn cho API: 매매 / 임대
  String? selectedRentType; // 월세 / 년세 (chỉ khi 임대)
  int? selectedLocationId;
  String? selectedLocationLabel;

  bool loading = false;
  bool loadingLocations = true;

  final GlobalKey locationKey = GlobalKey();

  // API DATA
  List<Map<String, dynamic>> locations = [];

  // dùng value Hàn để bắn API
  final rentTypes = ["월세", "년세"];

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  // ====================== LOAD LOCATIONS ======================
  void _loadLocations() async {
    try {
      final data = await PropertyService.getLocations();

      data.sort((a, b) => a["sort_order"].compareTo(b["sort_order"]));

      setState(() {
        locations = data;
        loadingLocations = false;
      });
    } catch (e) {
      loadingLocations = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppString.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(strings.search_title), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================== LOCATION =====================
            Text(
              strings.search_area,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            GestureDetector(
              key: locationKey,
              onTap: loadingLocations ? null : _openLocationPicker,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.black.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        loadingLocations
                            ? strings.search_loading_location
                            : (selectedLocationLabel ??
                                  strings.search_pick_location),
                        style: TextStyle(fontSize: 16.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25.h),

            // ===================== DEAL TYPE =====================
            Text(
              strings.search_deal_type,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                _buildSelectButton(keyValue: "매매", label: strings.deal_sale),
                SizedBox(width: 10.w),
                _buildSelectButton(keyValue: "임대", label: strings.deal_rent),
              ],
            ),

            SizedBox(height: 20.h),

            // ===================== RENT TYPE (ONLY IF 임대) =====================
            if (selectedDealType == "임대")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.search_rent_type,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: rentTypes.map((type) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(type), // vẫn hiển thị Hàn (월세 / 년세)
                        value: type,
                        groupValue: selectedRentType,
                        onChanged: (value) {
                          setState(() => selectedRentType = value);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),

            const Spacer(),

            // ===================== SEARCH BUTTON =====================
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: loading ? null : _onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1675D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        strings.search_button,
                        style: TextStyle(
                          fontSize: 20.sp,
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

  // ======================= DEAL BUTTON =======================
  Widget _buildSelectButton({
    required String keyValue, // value cho state + API: "매매"/"임대"
    required String label, // text hiển thị đa ngôn ngữ
  }) {
    final bool active = selectedDealType == keyValue;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDealType = keyValue;

            // reset radio khi từ 임대 chuyển sang 매매
            if (keyValue == "매매") selectedRentType = null;
          });
        },
        child: Container(
          height: 50.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: active ? Colors.white : Colors.grey.shade300,
            border: Border.all(color: active ? Colors.black : Colors.grey),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: active ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  // ========================== SEARCH ACTION ==========================
  void _onSearch() async {
    final strings = AppString.of(context);

    if (selectedLocationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(strings.error_pick_location)));
      return;
    }

    // Nếu chọn 임대 thì bắt buộc chọn 월세 / 년세
    if (selectedDealType == "임대" && selectedRentType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(strings.error_pick_rent_type)));
      return;
    }

    // Xác định property_type cho API
    late final String propertyType;

    if (selectedDealType == "매매") {
      propertyType = "매매";
    } else {
      // 임대
      propertyType = selectedRentType!; // 월세 hoặc 년세 (đã check null phía trên)
    }

    try {
      setState(() => loading = true);

      final results = await PropertyService.searchProperties(
        propertyType: propertyType,
        locationId: selectedLocationId!,
      );

      setState(() => loading = false);

      if (results.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(strings.search_no_result)));
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SearchResultScreen(results: results)),
      );
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${strings.error_search}: $e")));
    }
  }

  // ========================== LOCATION PICKER ==========================
  void _openLocationPicker() async {
    if (locations.isEmpty) return;

    final RenderBox box =
        locationKey.currentContext!.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);
    final size = box.size;

    final selected = await showMenu<Map<String, dynamic>>(
      context: context,
      position: RelativeRect.fromLTRB(
        pos.dx,
        pos.dy + size.height + 4,
        pos.dx + size.width,
        0,
      ),
      items: locations.map((loc) {
        return PopupMenuItem<Map<String, dynamic>>(
          value: loc,
          child: Text(loc["name"]),
        );
      }).toList(),
    );

    if (selected != null) {
      setState(() {
        selectedLocationId = selected["id"];
        selectedLocationLabel = selected["name"];
      });
    }
  }
}
