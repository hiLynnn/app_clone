import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_clone/models/quick_menu_model.dart';

class QuickMenuGrid extends StatelessWidget {
  final List<QuickMenuModel> items;

  const QuickMenuGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 12.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14.h,
        crossAxisSpacing: 14.w,
        childAspectRatio: 1.05,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return QuickMenuItem(item: items[index]);
      },
    );
  }
}

class QuickMenuItem extends StatelessWidget {
  final QuickMenuModel item;

  const QuickMenuItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(item.imageUrl, fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          // Title text
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
