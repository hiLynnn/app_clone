import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/views/property/property_detail_screen.dart';
import 'package:flutter/material.dart';

class PropertyResultItem extends StatelessWidget {
  final PropertyModel item;

  const PropertyResultItem({super.key, required this.item});

  void _openDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyDetailScreen(propertyId: item.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetail(context),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                item.image,
                width: 130,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),

            // TEXT INFO
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      "${item.propertyType} 매매 - ${item.location}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // PRICE
                    Text(
                      "${item.price} 원",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // OPTIONS
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: item.options.map((op) {
                        return Text(
                          "• ${op.name} ${op.value}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // BUTTON
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                height: 36,
                child: OutlinedButton(
                  onPressed: () => _openDetail(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: const Text("더보기"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
