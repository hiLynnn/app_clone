import 'package:app_clone/views/auth/login_screen.dart';
import 'package:app_clone/views/home/home_screen.dart';
import 'package:app_clone/views/landlord/landlord_dashboard/landlord_dashboard_screen.dart';
import 'package:app_clone/views/landlord_layout.dart';
import 'package:app_clone/views/main_layout.dart';
import 'package:app_clone/views/onboarding/onboarding_screen.dart';
import 'package:app_clone/views/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const LoginScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) =>
          MainLayout(location: state.uri.toString(), child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
          routes: const [],
        ),
      ],
    ),

    //landlord routes
    ShellRoute(
      builder: (context, state, child) =>
          LandlordLayout(location: state.uri.toString(), child: child),
      routes: [
        GoRoute(
          path: '/landlord/dashboard',
          builder: (context, state) => const LandlordDashboardScreen(),
        ),
      ],
    ),
  ],
);
