import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/property_model.dart';

class PropertyService {
  static const baseUrl = "https://api.sdfsdf.co.kr/api/properties.php";

  static Future<List<PropertyModel>> fetchHotProperties({
    int page = 1,
    int limit = 20,
  }) async {
    final url =
        "$baseUrl?page=$page&limit=$limit&sort=created&status=Active&is_published=1&special_filter=hot";

    print("CALL: $url");

    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer vebang-secret-token",
        "Accept": "application/json",
        "User-Agent": "Mozilla/5.0",
      },
    );

    print("STATUS: ${res.statusCode}");
    print("RAW: ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("API error ${res.statusCode}");
    }

    final data = jsonDecode(res.body);

    final List list = data["data"] ?? [];

    return list.map((e) => PropertyModel.fromJson(e)).toList();
  }

  // ================= SEARCH =================
  static Future<List<PropertyModel>> searchProperties({
    required String status,
    required List<String> types,
    required int? locationId,
  }) async {
    final uri = Uri.parse("http://42.115.7.129:8080/api/properties.php")
        .replace(
          queryParameters: {
            "status": status,
            "location_id": locationId?.toString(),
            "types": types.join(","),
            "is_published": "1",
            "sort": "created",
          }..removeWhere((key, value) => value == null),
        );

    final res = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer vebang-secret-token",
        "Accept": "application/json",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("API error: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);
    final List list = json["data"] ?? [];

    return list.map((e) => PropertyModel.fromJson(e)).toList();
  }
}
