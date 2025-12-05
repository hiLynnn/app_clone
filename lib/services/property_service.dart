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
  static Future<List<PropertyModel>> searchProperties({
    required String status,
    required List<String> types,
    required int? locationId,
  }) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        "status": status,
        "location_id": locationId?.toString(),
        "types": types.join(","),
        "is_published": "1",
        "sort": "created",
      }..removeWhere((key, value) => value == null),
    );

    print("SEARCH CALL: $uri");

    final res = await http.get(uri, headers: _headers);

    print("STATUS: ${res.statusCode}");
    print("RAW: ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);
    return (json["data"] as List)
        .map((e) => PropertyModel.fromJson(e))
        .toList();
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
}
