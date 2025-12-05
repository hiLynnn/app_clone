import 'package:app_clone/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  String selectedLanguageText = "English";

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  // ======================================
  // Load saved language
  // ======================================
  void _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString("app_lang") ?? "en";

    setState(() {
      selectedLanguageText = code == "en"
          ? "English"
          : code == "vi"
          ? "Vietnamese"
          : "한국어";
    });
  }

  // ======================================
  // Change language + save to SharedPreferences
  // ======================================
  void changeLanguage(String lang) async {
    late Locale newLocale;

    switch (lang) {
      case "en":
        newLocale = const Locale("en", "US");
        selectedLanguageText = "English";
        break;
      case "vi":
        newLocale = const Locale("vi", "VN");
        selectedLanguageText = "Vietnamese";
        break;
      case "ko":
        newLocale = const Locale("ko", "KR");
        selectedLanguageText = "한국어";
        break;
    }

    // Lưu vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("app_lang", lang);

    setState(() {});

    // Cập nhật ngôn ngữ của GetX
    Get.updateLocale(newLocale);
  }

  // ======================================
  // UI
  // ======================================
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: AppColors.background,
      title: Image.asset(
        'assets/images/logo.jpg',
        height: 36.h,
        fit: BoxFit.contain,
      ),
      actions: [
        Row(
          children: [
            // Language Dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: PopupMenuButton<String>(
                onSelected: changeLanguage,
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'en', child: Text("English")),
                  PopupMenuItem(value: 'vi', child: Text("Vietnamese")),
                  PopupMenuItem(value: 'ko', child: Text("한국어")),
                ],
                child: Row(
                  children: [
                    Icon(Icons.language, size: 20.sp, color: Colors.black87),
                    SizedBox(width: 6.w),
                    Text(
                      selectedLanguageText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.keyboard_arrow_down, size: 20.sp),
                  ],
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // Notification icon + badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 30.sp,
                  color: Colors.black87,
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 20.w),
          ],
        ),
      ],
    );
  }
}
