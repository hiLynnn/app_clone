import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Tab: $currentIndex", style: const TextStyle(fontSize: 24)),
      ),

      // ===============================
      //      NAVBAR CONG + NÚT LỒI
      // ===============================
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react, // icon phóng to khi chọn
        backgroundColor: Colors.white,
        activeColor: Colors.blue,
        color: Colors.grey,

        items: const [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.search, title: "Search"),
          TabItem(icon: Icons.add, title: "Add"), // nút lồi giữa
          TabItem(icon: Icons.favorite, title: "Fav"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],

        initialActiveIndex: 0,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}
