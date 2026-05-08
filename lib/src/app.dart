import 'package:flutter/material.dart';

import 'features/sonnenkompass/sonnenkompass_app.dart';

class SonnenkompassApp extends StatelessWidget {
  const SonnenkompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rammer Sonnenkompass MVP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE97A2B),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF7EE),
        useMaterial3: true,
      ),
      home: const SonnenkompassPrototypeApp(),
    );
  }
}
