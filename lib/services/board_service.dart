import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/board_model.dart';

class BoardService {
  static const String baseUrl = "https://api.sdfsdf.co.kr/api/boards.php";

  static Map<String, String> get _headers => {
    "Authorization": "Bearer vebang-secret-token",
    "Accept": "application/json",
  };

  static Future<List<BoardModel>> fetchBoards({
    required String category,
    int page = 1,
    int limit = 10,
  }) async {
    final url = Uri.parse(
      "$baseUrl?page=$page&limit=$limit&category=$category&is_published=1",
    );

    print("📌 CALL: $url");

    final res = await http.get(url, headers: _headers);

    print("📌 STATUS: ${res.statusCode}");
    print("📌 RAW: ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("API Error: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);

    return (json["data"] as List).map((e) => BoardModel.fromJson(e)).toList();
  }
}
