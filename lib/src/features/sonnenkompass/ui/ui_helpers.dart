import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildPageScaffold({
  required String title,
  required String subtitle,
  required Widget child,
  List<Widget> actions = const [],
}) {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(6, 8, 6, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 34,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFFF6EC),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF101010),
                                  border: Border.all(
                                    color: const Color(0xFF1C1A17),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'HANNES RAMMER',
                                  style: GoogleFonts.jetBrainsMono(
                                    color: const Color(0xFF756B60),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            child: Text(
                              subtitle,
                              style: const TextStyle(
                                color: Color(0xFF8A8177),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (actions.isNotEmpty) ...[
                      const SizedBox(width: 16),
                      Wrap(spacing: 10, runSpacing: 10, children: actions),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 28),
              child,
            ],
          ),
        ),
      ),
    ),
  );
}

Widget panel(String title, String subtitle, Widget child) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: const Color(0xFF0A0A0A),
      border: Border.all(color: const Color(0xFF191816)),
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.24),
          blurRadius: 32,
          offset: const Offset(0, 18),
        ),
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0C0C0B),
          Color(0xFF090909),
        ],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            letterSpacing: 2.8,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF675F57),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFD7C3AE),
            height: 1.15,
          ),
        ),
        const SizedBox(height: 18),
        child,
      ],
    ),
  );
}

Widget pill(String label, {bool dark = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: dark ? const Color(0xFFFFA31A) : const Color(0xFF101010),
      border: Border.all(
        color: dark ? const Color(0xFFFFA31A) : const Color(0xFF23211D),
      ),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label.toUpperCase(),
      style: GoogleFonts.jetBrainsMono(
        color: dark ? const Color(0xFF18110A) : const Color(0xFF938779),
        fontWeight: FontWeight.w700,
        fontSize: 11,
        letterSpacing: 1.2,
      ),
    ),
  );
}

String workLabel(dynamic mode) => mode.toString().split('.').last;
