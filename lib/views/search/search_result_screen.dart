import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/views/search/widgets/property_result_item.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final List<PropertyModel> results;

  const SearchResultScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("검색 결과")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, i) => PropertyResultItem(item: results[i]),
      ),
    );
  }
}
