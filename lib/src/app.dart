import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/sonnenkompass/sonnenkompass_app.dart';

class SonnenkompassApp extends StatelessWidget {
  const SonnenkompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rammer Sonnenkompass MVP',
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
            color: Colors.white
          ),
          bodyLarge: const TextStyle(color: Color(0xFFE0E0E0)),
          bodyMedium: const TextStyle(color: Color(0xFFCCCCCC)),
          labelSmall: GoogleFonts.jetbrainsMono(
            letterSpacing: 2.0, 
            color: const Color(0xFF555555),
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF0A0A0A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: const BorderSide(color: Color(0xFF1A1A1A), width: 1),
          ),
        ),
        useMaterial3: true,
      ),
      home: const SonnenkompassPrototypeApp(),
    );
  }
}
