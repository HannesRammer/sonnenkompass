import 'package:flutter/material.dart';

Widget buildPageScaffold({
  required String title,
  required String subtitle,
  required Widget child,
  List<Widget> actions = const [],
}) {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(0xFF9A9A9A),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (actions.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    Wrap(spacing: 8, runSpacing: 8, children: actions),
                  ],
                ],
              ),
              const SizedBox(height: 24),
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
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: const Color(0xFF0A0A0A),
      border: Border.all(color: const Color(0xFF1E1E1E)),
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF888888), height: 1.4),
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
      color: dark ? const Color(0xFFF59E0B) : const Color(0xFF111111),
      border: dark ? null : Border.all(color: const Color(0xFF222222)),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: dark ? const Color(0xFF111111) : const Color(0xFFAAAAAA),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}

String workLabel(dynamic mode) => mode.toString().split('.').last;
