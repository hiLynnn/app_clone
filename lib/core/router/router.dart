import 'package:app_clone/views/auth/forgot_password_screen.dart';
import 'package:app_clone/views/auth/login_screen.dart';
import 'package:app_clone/views/auth/register_screen.dart';
import 'package:app_clone/views/booking/bookings_list/bookings_list_screen.dart';
import 'package:app_clone/views/chat/messages_screen.dart';
import 'package:app_clone/views/favorites/favorites_screen.dart';
import 'package:app_clone/views/home/home_screen.dart';
import 'package:app_clone/views/landlord/landlord_bookings/landlord_bookings_screen.dart';
import 'package:app_clone/views/landlord/landlord_dashboard/landlord_dashboard_screen.dart';
import 'package:app_clone/views/landlord/landlord_profile/landlord_profile_screen.dart';
import 'package:app_clone/views/landlord/landlord_properties/landlord_properties_screen.dart';
import 'package:app_clone/views/landlord_layout.dart';
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
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/bookings',
          builder: (context, state) => const BookingsListScreen(),
        ),
        GoRoute(
          path: '/messages',
          builder: (context, state) => const MessagesScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
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
        GoRoute(
          path: '/landlord/properties',
          builder: (context, state) => const LandlordPropertiesScreen(),
        ),
        GoRoute(
          path: '/landlord/messages',
          builder: (context, state) => const MessagesScreen(),
        ),
        GoRoute(
          path: '/landlord/bookings',
          builder: (context, state) => const LandlordBookingsScreen(),
        ),
        GoRoute(
          path: '/landlord/profile',
          builder: (context, state) => const LandlordProfileScreen(),
        ),
      ],
    ),
  ],
);
