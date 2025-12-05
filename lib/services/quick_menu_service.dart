import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quick_menu_model.dart';

class QuickMenuService {
  static const String url = "https://api.sdfsdf.co.kr/api/quick_menus.php";

  static const String cacheKey = "cache_quick_menus";

  static Future<List<QuickMenuModel>> fetchQuickMenus() async {
    final prefs = await SharedPreferences.getInstance();

    print("CALL QuickMenu: $url");

    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer vebang-secret-token",
          "Accept": "application/json",
        },
      );

      print("STATUS: ${res.statusCode}");
      print("RAW: ${res.body}");

      if (res.statusCode == 200) {
        // Save cache
        await prefs.setString(cacheKey, res.body);

        final data = jsonDecode(res.body);
        final List list = data["data"] ?? [];

        return list.map((e) => QuickMenuModel.fromJson(e)).toList();
      }

      throw Exception("API error ${res.statusCode}");
    } catch (e) {
      print("QuickMenus API FAILED — using cache instead...");
      print("ERROR: $e");

      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        final data = jsonDecode(cached);
        final List list = data["data"] ?? [];

        return list.map((e) => QuickMenuModel.fromJson(e)).toList();
      }

      rethrow;
    }
  }
}
