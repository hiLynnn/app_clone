import 'package:app_clone/views/auth/forgot_password_screen.dart';
import 'package:app_clone/views/auth/login_screen.dart';
import 'package:app_clone/views/auth/register_screen.dart';
import 'package:app_clone/views/search/search_screen.dart';
import 'package:app_clone/views/board/board_screen.dart';
import 'package:app_clone/views/nearby/nearby_screen.dart';
import 'package:app_clone/views/home/home_screen.dart';
import 'package:app_clone/views/main_layout.dart';
import 'package:app_clone/views/onboarding/onboarding_screen.dart';
import 'package:app_clone/views/profile/profile_screen.dart';
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
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
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
        GoRoute(
          path: '/nearby',
          builder: (context, state) => const NearbyScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/board',
          builder: (context, state) => const BoardScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
