import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_scope.dart';
import '../../core/app_store.dart';
import 'ui/app_shell.dart';
import 'ui/dashboard_page.dart';
import 'ui/idea_detail_page.dart';
import 'ui/project_detail_page.dart';
import 'ui/rays_page.dart';
import 'ui/review_page.dart';
import 'ui/today_page.dart';

class SonnenkompassPrototypeApp extends StatefulWidget {
  const SonnenkompassPrototypeApp({super.key});

  @override
  State<SonnenkompassPrototypeApp> createState() =>
      _SonnenkompassPrototypeAppState();
}

class _SonnenkompassPrototypeAppState extends State<SonnenkompassPrototypeApp> {
  SonnenkompassStore? _store;
  GoRouter? _router;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final store = await SonnenkompassStore.load();
    final router = GoRouter(
      initialLocation: '/dashboard',
      refreshListenable: store,
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppScope(
            store: store,
            child: AppShell(child: child),
          ),
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
            GoRoute(
              path: '/today',
              builder: (context, state) => const TodayPage(),
            ),
            GoRoute(
              path: '/rays',
              builder: (context, state) => const RaysPage(),
            ),
            GoRoute(
              path: '/rays/:rayId',
              builder: (context, state) =>
                  RaysPage(rayId: state.pathParameters['rayId']),
            ),
            GoRoute(
              path: '/projects/:projectId',
              builder: (context, state) => ProjectDetailPage(
                projectId: state.pathParameters['projectId']!,
              ),
            ),
            GoRoute(
              path: '/ideas/:ideaId',
              builder: (context, state) => IdeaDetailPage(
                ideaId: state.pathParameters['ideaId']!,
              ),
            ),
            GoRoute(
              path: '/review',
              builder: (context, state) => const ReviewPage(),
            ),
          ],
        ),
      ],
    );

    if (!mounted) return;
    setState(() {
      _store = store;
      _router = router;
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = _router;
    if (router == null || _store == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp.router(
      title: 'Sonnenkompass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        primaryColor: const Color(0xFFF59E0B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF59E0B),
          secondary: Color(0xFFFBBF24),
          surface: Color(0xFF0A0A0A),
          onSurface: Color(0xFFE0E0E0),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          bodyLarge: const TextStyle(color: Color(0xFFE0E0E0)),
          bodyMedium: const TextStyle(color: Color(0xFFCCCCCC)),
          labelSmall: GoogleFonts.jetBrainsMono(
            letterSpacing: 2.0,
            color: const Color(0xFF555555),
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
