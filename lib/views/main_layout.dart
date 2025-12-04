import 'package:app_clone/core/common/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String location;

  const MainLayout({super.key, required this.child, required this.location});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _getIndexFromLocation(widget.location);
  }

  @override
  void didUpdateWidget(MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      setState(() {
        _currentIndex = _getIndexFromLocation(widget.location);
      });
    }
  }

  int _getIndexFromLocation(String location) {
    if (location.startsWith('/search')) return 0;
    if (location.startsWith('/nearby')) return 1;
    if (location.startsWith('/home')) return 2;
    if (location.startsWith('/board')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 2; //default to home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/search');
              break;
            case 1:
              context.go('/nearby');
              break;
            case 2:
              context.go('/home');
              break;
            case 3:
              context.go('/board');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}
