import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("게시판"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _sectionHeader(icon: Icons.campaign, titleKr: "공지사항"),
            _item("서비스 점검 안내"),
            _item("서비스 점검 안내"),
            _item("이용약관 개정 안내"),
            const SizedBox(height: 26),

            _sectionHeader(icon: Icons.card_giftcard, titleKr: "이벤트"),
            _item("2월 출석 체크 이벤트"),
            _item("친구 초대 이벤트"),
            _item("친구 초대 이벤트"),
          ],
        ),
      ),
    );
  }

  // ---------------- SECTION HEADER ----------------
  Widget _sectionHeader({required IconData icon, required String titleKr}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleKr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  // ---------------- ITEM ----------------
  Widget _item(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
