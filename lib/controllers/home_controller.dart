import 'dart:convert';

import 'package:app_clone/models/banner_model.dart';
import 'package:app_clone/models/quick_menu_model.dart';
import 'package:app_clone/services/banner_service.dart';
import 'package:app_clone/services/quick_menu_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var banners = <BannerModel>[].obs;
  var secondBanners = <BannerModel>[].obs;

  final quickMenus = <QuickMenuModel>[].obs;

  // Loading
  var isBannerLoading = true.obs;
  final isSecondBannerLoading = false.obs;
  final isQuickMenuLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void loadHomeData() {
    fetchBanners();
    fetchSecondBanners();
    fetchQuickMenus();
  }

  Future<void> fetchBanners() async {
    try {
      isBannerLoading(true);
      final data = await BannerService.getMainBanners();
      banners.assignAll(data);
    } finally {
      isBannerLoading(false);
    }
  }

  Future<void> fetchSecondBanners() async {
    try {
      isBannerLoading(true);
      final data = await BannerService.getSecondBanners();
      secondBanners.assignAll(data);
    } finally {
      isSecondBannerLoading(false);
    }
  }

  Future<void> fetchQuickMenus() async {
    try {
      isQuickMenuLoading(true);
      final data = await QuickMenuService.fetchQuickMenus();
      quickMenus.assignAll(data);
    } finally {
      isQuickMenuLoading(false);
    }
  }
}
