import 'dart:convert';
import '../models/property.dart';
import 'package:http/http.dart' as http;

Future<List<Property>> fetchList() async {
  final url = Uri.parse(
    "http://42.115.7.129:8080/api/properties.php?page=1&limit=10",
  );

  final res = await http.get(url);

  print("STATUS: ${res.statusCode}");
  print("BODY: ${res.body}");

  if (res.statusCode != 200) {
    throw Exception("API error: ${res.statusCode}");
  }

  try {
    final json = jsonDecode(res.body);

    final List<Property> list = (json['data'] as List)
        .map((e) => Property.fromJson(e))
        .toList();

    return list;
  } catch (e) {
    print("JSON PARSE ERROR → $e");
    throw Exception("Invalid JSON from API");
  }
}
