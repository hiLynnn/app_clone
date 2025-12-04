import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_clone/models/quick_menu_model.dart';

class QuickMenuService {
  static const String url = "http://42.115.7.129:8080/api/quick_menus.php";

  static Future<List<QuickMenuModel>> fetchQuickMenus() async {
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer vebang-secret-token",
        "Accept": "application/json",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to load quick menus");
    }

    final json = jsonDecode(res.body);
    final List list = json["data"] ?? [];

    return list.map((e) => QuickMenuModel.fromJson(e)).toList();
  }
}
