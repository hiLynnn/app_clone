import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_clone/models/banner_model.dart';

class BannerService {
  static const String baseUrl = "https://api.sdfsdf.co.kr";

  static const String cacheKeyMain1 = "cache_main_banners";
  static const String cacheKeyMain2 = "cache_second_banners";

  /// =========================
  /// MAIN1 BANNERS
  /// =========================
  static Future<List<BannerModel>> getMainBanners() async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
      "$baseUrl/api/banners.php?category=main1&limit=100&type=public",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer vebang-secret-token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // Save cache
        await prefs.setString(cacheKeyMain1, response.body);

        final jsonData = jsonDecode(response.body);
        final List data = jsonData["data"] ?? [];

        return data.map((e) => BannerModel.fromJson(e)).toList();
      }

      throw Exception("API error");
    } catch (_) {
      // Load from cache
      final cached = prefs.getString(cacheKeyMain1);

      if (cached != null) {
        final jsonData = jsonDecode(cached);
        final List data = jsonData["data"] ?? [];

        print("API main1 failed → using cached data");
        return data.map((e) => BannerModel.fromJson(e)).toList();
      }

      rethrow;
    }
  }

  /// =========================
  /// MAIN2 BANNERS
  /// =========================
  static Future<List<BannerModel>> getSecondBanners() async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
      "$baseUrl/api/banners.php?category=main2&limit=100&type=public",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer vebang-secret-token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // Save cache
        await prefs.setString(cacheKeyMain2, response.body);

        final jsonData = jsonDecode(response.body);
        final List data = jsonData["data"] ?? [];

        return data.map((e) => BannerModel.fromJson(e)).toList();
      }

      throw Exception("API error");
    } catch (_) {
      // Load from cache
      final cached = prefs.getString(cacheKeyMain2);

      if (cached != null) {
        final jsonData = jsonDecode(cached);
        final List data = jsonData["data"] ?? [];

        print("API main2 failed → using cached data");
        return data.map((e) => BannerModel.fromJson(e)).toList();
      }

      rethrow;
    }
  }
}
