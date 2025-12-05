import 'package:app_clone/views/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            HomeAppBar(), // AppBar dùng chung
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
