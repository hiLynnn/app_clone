import 'dart:convert';

import 'package:app_clone/models/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerService {
  static const String baseUrl = "https://api.sdfsdf.co.kr/";

  static Future<List<BannerModel>> getMainBanners() async {
    final url = Uri.parse(
      "$baseUrl/api/banners.php?category=main1&limit=100&type=public",
    );

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer vebang-secret-token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final List<dynamic> data = jsonData["data"];

      return data.map((e) => BannerModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load banners. Code: ${response.statusCode}");
    }
  }

  static Future<List<BannerModel>> getSecondBanners() async {
    final url = Uri.parse(
      "$baseUrl/api/banners.php?category=main2&limit=100&type=public",
    );

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer vebang-secret-token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final List<dynamic> data = jsonData["data"];

      return data.map((e) => BannerModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load banners. Code: ${response.statusCode}");
    }
  }
}
