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
  String selectedLanguageText = "English"; // Default UI text
  String selectedLangCode = "en"; // Anh, Việt, Hàn

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  // ======================================
  // Load language from SharedPreferences
  // ======================================
  void _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString("app_lang") ?? "en";

    Locale locale;

    switch (lang) {
      case "vi":
        locale = const Locale("vi", "VN");
        selectedLanguageText = "Vietnamese";
        break;
      case "ko":
        locale = const Locale("ko", "KR");
        selectedLanguageText = "한국어";
        break;
      default:
        locale = const Locale("en", "US");
        selectedLanguageText = "English";
        break;
    }

    selectedLangCode = lang;

    // update lại locale khi mở app
    Get.updateLocale(locale);

    if (mounted) setState(() {});
  }

  // ======================================
  // Change language + save to SharedPreferences
  // ======================================
  void changeLanguage(String lang) async {
    Locale newLocale;
    selectedLangCode = lang;

    switch (lang) {
      case "vi":
        newLocale = const Locale("vi", "VN");
        selectedLanguageText = "Vietnamese";
        break;
      case "ko":
        newLocale = const Locale("ko", "KR");
        selectedLanguageText = "한국어";
        break;
      default:
        newLocale = const Locale("en", "US");
        selectedLanguageText = "English";
        break;
    }

    // Save
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("app_lang", lang);

    if (mounted) setState(() {});

    // Update app language
    Get.updateLocale(newLocale);
  }

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
            // ===========================
            // LANGUAGE DROPDOWN
            // ===========================
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: PopupMenuButton<String>(
                initialValue: selectedLangCode,
                onSelected: changeLanguage,
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'en', child: Text("English")),
                  PopupMenuItem(value: 'vi', child: Text("Tiếng Việt")),
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

            // ===========================
            // NOTIFICATION ICON
            // ===========================
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
