import 'package:app_clone/models/banner_model.dart';
import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/models/quick_menu_model.dart';
import 'package:app_clone/services/banner_service.dart';
import 'package:app_clone/services/property_service.dart';
import 'package:app_clone/services/quick_menu_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // DATA
  var banners = <BannerModel>[].obs;
  var secondBanners = <BannerModel>[].obs;
  var quickMenus = <QuickMenuModel>[].obs;
  var hotProperties = <PropertyModel>[].obs;

  // LOADING STATES
  var isBannerLoading = false.obs;
  var isSecondBannerLoading = false.obs;
  var isQuickMenuLoading = false.obs;
  var isHotLoading = false.obs;
  bool isLoaded = false;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  // ================================
  // LOAD ALL HOME DATA (song song)
  // ================================
  Future<void> loadHomeData() async {
    if (isLoaded) return;
    isLoaded = true;
    await Future.wait([
      fetchBanners(),
      fetchSecondBanners(),
      fetchQuickMenus(),
      fetchHotProperties(),
    ]);
  }

  // ================================
  // MAIN Banners
  // ================================
  Future<void> fetchBanners() async {
    try {
      isBannerLoading(true);
      banners.assignAll(await BannerService.getMainBanners());
    } finally {
      isBannerLoading(false);
    }
  }

  // ================================
  // SECOND Banners
  // ================================
  Future<void> fetchSecondBanners() async {
    try {
      isSecondBannerLoading(true);
      secondBanners.assignAll(await BannerService.getSecondBanners());
    } finally {
      isSecondBannerLoading(false);
    }
  }

  // ================================
  // QUICK MENU
  // ================================
  Future<void> fetchQuickMenus() async {
    try {
      isQuickMenuLoading(true);
      quickMenus.assignAll(await QuickMenuService.fetchQuickMenus());
    } finally {
      isQuickMenuLoading(false);
    }
  }

  Future<void> fetchHotProperties() async {
    // ⭐ Không load lại nếu đã có dữ liệu
    if (hotProperties.isNotEmpty) return;

    try {
      isHotLoading(true);

      final data = await PropertyService.fetchHotProperties();
      hotProperties.assignAll(data);
    } finally {
      isHotLoading(false);
    }
  }
}
