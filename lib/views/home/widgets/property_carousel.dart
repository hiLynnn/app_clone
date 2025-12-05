import 'dart:math';

import 'package:app_clone/models/property_model.dart';
import 'package:app_clone/views/home/widgets/property_card.dart';
import 'package:app_clone/views/property/property_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyCarouselPager extends StatefulWidget {
  final List<PropertyModel> items;

  const PropertyCarouselPager({super.key, required this.items});

  @override
  State<PropertyCarouselPager> createState() => _PropertyCarouselPagerState();
}

class _PropertyCarouselPagerState extends State<PropertyCarouselPager> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  List<List<PropertyModel>> _chunk(List<PropertyModel> data, int size) {
    List<List<PropertyModel>> pages = [];
    for (int i = 0; i < data.length; i += size) {
      pages.add(data.sublist(i, min(i + size, data.length)));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _chunk(widget.items, 4);

    return SizedBox(
      height: 400.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // PAGEVIEW GRID
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (i) {
              setState(() => pageIndex = i);
            },
            itemBuilder: (context, page) {
              final pageItems = pages[page];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pageItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, i) {
                    final item = pageItems[i];

                    return PropertyCard(
                      property: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PropertyDetailScreen(propertyId: item.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),

          // LEFT BUTTON
          Positioned(
            left: 0,
            child: _NavButton(
              icon: Icons.chevron_left,
              enabled: pageIndex > 0,
              onTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),

          // RIGHT BUTTON
          Positioned(
            right: 0,
            child: _NavButton(
              icon: Icons.chevron_right,
              enabled: pageIndex < pages.length - 1,
              onTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled
              ? Colors.black.withOpacity(0.05)
              : Colors.grey.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 22,
          color: enabled ? Colors.black87 : Colors.grey,
        ),
      ),
    );
  }
}
