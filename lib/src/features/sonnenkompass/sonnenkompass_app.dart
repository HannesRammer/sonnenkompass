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
      initialLocation: _initialLocationFromBrowser(),
      overridePlatformDefaultLocation: true,
      refreshListenable: store,
      redirect: (context, state) => state.uri.path == '/' ? '/dashboard' : null,
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
      themeAnimationDuration: Duration.zero,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF040404),
        primaryColor: const Color(0xFFFFA31A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFA31A),
          secondary: Color(0xFFFFC247),
          surface: Color(0xFF0B0B0B),
          onSurface: Color(0xFFF2E7D8),
        ),
        textTheme: GoogleFonts.instrumentSansTextTheme(
          ThemeData.dark().textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.cormorantGaramond(
            fontStyle: FontStyle.italic,
            color: const Color(0xFFFFF8F0),
            fontSize: 48,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: GoogleFonts.cormorantGaramond(
            fontStyle: FontStyle.italic,
            color: const Color(0xFFFFF6ED),
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: GoogleFonts.cormorantGaramond(
            fontStyle: FontStyle.italic,
            color: const Color(0xFFF4E8D7),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: const TextStyle(
            color: Color(0xFFE3D5C3),
            height: 1.5,
          ),
          bodyMedium: const TextStyle(
            color: Color(0xFFB2A595),
            height: 1.5,
          ),
          labelLarge: GoogleFonts.instrumentSans(
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
          ),
          labelSmall: GoogleFonts.jetBrainsMono(
            letterSpacing: 2.8,
            color: const Color(0xFF6E655B),
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        dividerColor: const Color(0xFF1A1A1A),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: Color(0xFF050505),
          selectedIconTheme: IconThemeData(color: Color(0xFFFFA31A)),
          unselectedIconTheme: IconThemeData(color: Color(0xFF5A534C)),
          selectedLabelTextStyle: TextStyle(
            color: Color(0xFFF1E1CD),
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: Color(0xFF7A7167),
            fontWeight: FontWeight.w500,
          ),
          indicatorColor: Color(0x111A1A1A),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF070707),
          indicatorColor: const Color(0x18FFA31A),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              color: states.contains(WidgetState.selected)
                  ? const Color(0xFFF2E3CF)
                  : const Color(0xFF72695F),
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFFFA31A),
            foregroundColor: const Color(0xFF140E09),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFEADBC8),
            side: const BorderSide(color: Color(0xFF24201C)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Color(0xFF8F8578),
          textColor: Color(0xFFF0E4D4),
          subtitleTextStyle: TextStyle(
            color: Color(0xFF9D9387),
            height: 1.4,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? const Color(0xFFFFA31A)
                : Colors.transparent,
          ),
          side: const BorderSide(color: Color(0xFF4A433C)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF0A0A0A),
          labelStyle: const TextStyle(color: Color(0xFF9E9387)),
          hintStyle: const TextStyle(color: Color(0xFF6F665D)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF1E1A16)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF1E1A16)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFFFA31A)),
          ),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

String _initialLocationFromBrowser() {
  final uri = Uri.base;
  final path = uri.path;
  final isAppPath = _topLevelRoutes.contains(path) ||
      path.startsWith('/rays/') ||
      path.startsWith('/projects/') ||
      path.startsWith('/ideas/');

  if (!isAppPath) return '/dashboard';
  return uri.hasQuery ? '$path?${uri.query}' : path;
}

const _topLevelRoutes = {
  '/dashboard',
  '/today',
  '/rays',
  '/review',
};
