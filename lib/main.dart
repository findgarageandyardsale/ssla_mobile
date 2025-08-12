import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'utils/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/notice_board_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/rules_screen.dart';
import 'screens/image_notice_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize notification service
  await NotificationService().initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SSLA School',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary, // Orange
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/courses',
      name: 'courses',
      builder: (context, state) => const CoursesScreen(),
    ),
    GoRoute(
      path: '/gallery',
      name: 'gallery',
      builder: (context, state) => const GalleryScreen(),
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/notices',
      name: 'notices',
      builder: (context, state) => const NoticeBoardScreen(),
    ),
    GoRoute(
      path: '/calendar',
      name: 'calendar',
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: '/registration',
      name: 'registration',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/rules',
      name: 'rules',
      builder: (context, state) => const RulesScreen(),
    ),
    GoRoute(
      path: '/image-notice',
      name: 'image-notice',
      builder: (context, state) {
        final title = state.uri.queryParameters['title'] ?? 'Image Notice';
        final imageURL = state.uri.queryParameters['imageURL'] ?? '';
        return ImageNoticeScreen(title: title, imageURL: imageURL);
      },
    ),
  ],
);
