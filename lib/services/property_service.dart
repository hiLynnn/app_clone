import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/property_model.dart';

class PropertyService {
  static const String baseUrl = "https://api.sdfsdf.co.kr/api/properties.php";
  static const String detailUrl =
      "https://api.sdfsdf.co.kr/api/property_detail.php";

  static const String cacheHotKey = "cache_hot_properties";

  static Map<String, String> get _headers => {
    "Authorization": "Bearer vebang-secret-token",
    "Accept": "application/json",
    "User-Agent": "Mozilla/5.0",
  };

  // ================= HOT PROPERTIES =================
  static Future<List<PropertyModel>> fetchHotProperties({
    int page = 1,
    int limit = 20,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final url =
        "$baseUrl?page=$page&limit=$limit&sort=created&status=Active&is_published=1&special_filter=hot";

    print("CALL: $url");

    try {
      final res = await http.get(Uri.parse(url), headers: _headers);

      print("STATUS: ${res.statusCode}");
      print("RAW: ${res.body}");

      if (res.statusCode == 200) {
        await prefs.setString(cacheHotKey, res.body);
        final data = jsonDecode(res.body);
        return (data["data"] as List)
            .map((e) => PropertyModel.fromJson(e))
            .toList();
      }

      throw Exception("API error ${res.statusCode}");
    } catch (_) {
      final cached = prefs.getString(cacheHotKey);
      if (cached != null) {
        final data = jsonDecode(cached);
        return (data["data"] as List)
            .map((e) => PropertyModel.fromJson(e))
            .toList();
      }
      rethrow;
    }
  }

  // ================= SEARCH PROPERTIES =================
  //
  // API docs:
  // - status: Active / Pending / Sold
  // - property_type: 매매 / 월세 / 년세
  static Future<List<PropertyModel>> searchProperties({
    required String propertyType, // 매매 / 월세 / 년세
    required int locationId,
    int page = 1,
    int limit = 20,
  }) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        "page": "$page",
        "limit": "$limit",
        "sort": "created",
        "status": "Active",
        "is_published": "1",
        "location_id": "$locationId",
        "property_type": propertyType,
      },
    );

    print("SEARCH CALL: $uri");

    final res = await http.get(uri, headers: _headers);

    print("STATUS: ${res.statusCode}");
    print("RAW: ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);
    final List data = json["data"] ?? [];

    return data.map((e) => PropertyModel.fromJson(e)).toList();
  }

  // ================= PROPERTY DETAIL =================
  static Future<PropertyModel> fetchPropertyDetail(int id) async {
    final uri = Uri.parse("$detailUrl?id=$id");

    print("CALL Detail: $uri");

    final res = await http.get(uri, headers: _headers);

    print("DETAIL STATUS: ${res.statusCode}");
    print("DETAIL RAW: ${res.body}");

    final json = jsonDecode(res.body);
    return PropertyModel.fromJson(json);
  }

  // ================= LOCATIONS (KHU VỰC) =================
  static Future<List<Map<String, dynamic>>> getLocations() async {
    const url = "https://api.sdfsdf.co.kr/api/locations.php?is_active=1";

    print("CALL Locations: $url");

    final res = await http.get(Uri.parse(url), headers: _headers);

    print("LOC STATUS: ${res.statusCode}");
    print("LOC RAW: ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("Failed to load locations (${res.statusCode})");
    }

    final json = jsonDecode(res.body);

    if (json["success"] != true) {
      throw Exception(json["message"] ?? "Location API error");
    }

    final List data = json["data"];

    return data.map<Map<String, dynamic>>((loc) {
      return {
        "id": loc["id"],
        "name": loc["name"],
        "sort_order": loc["sort_order"],
        "is_active": loc["is_active"],
      };
    }).toList();
  }
}
