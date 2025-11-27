import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'used_market_page.dart'; // TRANG LIST 새로 추가
import 'widgets/banner_slider.dart';
import 'widgets/top_category_item.dart';
import 'widgets/section_title.dart';
import 'widgets/popular_category_card.dart';

class HotyHomePage extends StatefulWidget {
  const HotyHomePage({super.key});

  @override
  State<HotyHomePage> createState() => _HotyHomePageState();
}

class _HotyHomePageState extends State<HotyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ===========================
    // BODY SWITCHER
    // ===========================
    final pages = [
      _buildHome(size), // HOME
      const UsedMarketPage(), // 중고거래 페이지
      const Center(child: Text("Add Page")),
      const Center(child: Text("Favorite Page")),
      const Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.white,
        activeColor: Colors.orange,
        color: Colors.grey,
        items: const [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.list_alt, title: "List"),
          TabItem(icon: Icons.add, title: "Add"),
          TabItem(icon: Icons.favorite_border, title: "Fav"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        initialActiveIndex: 0,
        onTap: (i) => setState(() => currentIndex = i),
      ),

      body: SafeArea(child: pages[currentIndex]),
    );
  }

  // ===========================
  // HOME UI (m code sẵn)
  // ===========================
  Widget _buildHome(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ---------- HEADER ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, size: 30),
                Image.asset("assets/images/logo.webp", height: 60),
                const Icon(Icons.notifications_none, size: 28),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ---------- BANNER SLIDER ----------
          BannerSlider(size: size),

          const SizedBox(height: 24),

          // ---------- TOP CATEGORY ----------
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                TopCategoryItem(
                  icon: Icons.shopping_cart_outlined,
                  label: "업체추천",
                ),
                TopCategoryItem(icon: Icons.home_outlined, label: "중고거래"),
                TopCategoryItem(icon: Icons.work_outline, label: "구인구직"),
                TopCategoryItem(icon: Icons.local_cafe_outlined, label: "기타"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            color: const Color(0xFFF0F5FA),
            height: 10,
            width: double.infinity,
          ),

          const SizedBox(height: 20),

          // ---------- 인기카테고리 ----------
          const SectionTitle(title: "인기카테고리"),

          const SizedBox(height: 16),

          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                PopularCategoryCard(
                  icon: Icons.notifications_active_outlined,
                  label: "오늘의 정보",
                  bgColor: Color(0xFFEAF1FF),
                  iconColor: Color(0xFF2E6CE2),
                ),
                PopularCategoryCard(
                  icon: Icons.home_work_outlined,
                  label: "중고거래",
                  bgColor: Color(0xFFE3F7F3),
                  iconColor: Color(0xFF3AB19B),
                ),
                PopularCategoryCard(
                  icon: Icons.school_outlined,
                  label: "지식 in",
                  bgColor: Color(0xFFEAF4FF),
                  iconColor: Color(0xFF4893F8),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            color: const Color(0xFFF0F5FA),
            height: 10,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
