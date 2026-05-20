import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/models.dart';
import '../../../core/app_scope.dart';
import '../../../core/app_store.dart';
import 'ui_helpers.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return buildPageScaffold(
      title: 'Sonnenkompass',
      subtitle:
          'Kernfokus, Fixkreis, Orbit, Strahlen und Zeitstrahlen in einer echten Web-App-Struktur.',
      actions: [
        FilledButton(
          onPressed: () => context.go('/today'),
          child: const Text('Zu Heute'),
        ),
        OutlinedButton(
          onPressed: () => context.go('/review'),
          child: const Text('Review oeffnen'),
        ),
      ],
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 1160;
              final left = panel(
                'Sonnenkompass Modell',
                'Die App soll nicht nur Listen zeigen, sondern dein System als Schichten lesbar machen.',
                _CompassDiagram(
                  primaryProject: store.primaryProject,
                  secondaryProjects: store.secondaryProjects,
                  rays: store.rays,
                  timeRays: _buildTimeRays(store),
                  fixItems: _buildFixItems(store),
                ),
              );
              final right = panel(
                'Heute im Kern',
                'Warum diese Schichtung Sinn macht und was heute real aktiv ist.',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.primaryProject.name,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFFFFF3E7),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      store.primaryProject.currentGoal,
                      style: const TextStyle(
                        color: Color(0xFFAAAAAA),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        pill('Arbeit ${_workLabel(store.focusDay.workMode)}'),
                        pill(
                            'Energie ${_energyLabel(store.focusDay.energyLevel)}'),
                        pill(
                            'Bewegung ${_movementStatus(store.movementPlan.status)}'),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _orbitCard(
                      'Kern',
                      store.primaryProject.name,
                      store.primaryProject.currentGoal,
                    ),
                    const SizedBox(height: 10),
                    ...store.secondaryProjects.map(
                      (project) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _orbitCard(
                          'Orbit',
                          project.name,
                          project.currentGoal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Fixkreis heute',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF1E4D2),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _buildFixItems(store).map(pill).toList(),
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FilledButton(
                          onPressed: () => context
                              .go('/projects/${store.primaryProject.id}'),
                          child: const Text('Projekt oeffnen'),
                        ),
                        OutlinedButton(
                          onPressed: () =>
                              context.go('/rays/${store.primaryProject.rayId}'),
                          child: const Text('Zum Strahl'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              if (stacked) {
                return Column(
                  children: [left, const SizedBox(height: 18), right],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: left),
                  const SizedBox(width: 18),
                  Expanded(flex: 5, child: right),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 1000;
              final left = panel(
                'Naechste Schritte',
                'Muss heute passieren und darf nicht im schoensten Layout stecken bleiben.',
                Column(
                  children: [
                    ...store.mustDoTasks
                        .map((task) => _taskTile(task, context)),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton(
                        onPressed: () => context.go('/today'),
                        child: const Text('Alle Tagesaufgaben sehen'),
                      ),
                    ),
                  ],
                ),
              );
              final right = panel(
                'Zeitstrahlen',
                'Nicht nur was wichtig ist, sondern wann es im Tag Platz bekommt.',
                Column(
                  children: _buildTimeRays(store)
                      .map(
                        (timeRay) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _orbitCard(
                            timeRay.label,
                            timeRay.title,
                            timeRay.body,
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
              if (stacked) {
                return Column(
                  children: [left, const SizedBox(height: 18), right],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: left),
                  const SizedBox(width: 18),
                  Expanded(child: right),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _orbitCard(String label, String title, String body) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF1D1B18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xFFFFA31A),
              fontSize: 11,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.cormorantGaramond(
              color: const Color(0xFFFFF4E8),
              fontSize: 26,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF9D9387),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskTile(Task task, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go('/projects/${task.projectId ?? ''}'),
    );
  }
}

class _CompassDiagram extends StatelessWidget {
  const _CompassDiagram({
    required this.primaryProject,
    required this.secondaryProjects,
    required this.rays,
    required this.timeRays,
    required this.fixItems,
  });

  final Project primaryProject;
  final List<Project> secondaryProjects;
  final List<Ray> rays;
  final List<_TimeRay> timeRays;
  final List<String> fixItems;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final labelGutter = math.min(
          110.0,
          math.max(72.0, availableWidth * 0.12),
        );
        final ringSize = math.min(
          620.0,
          math.max(320.0, availableWidth - (labelGutter * 2)),
        );
        final canvasSize = ringSize + (labelGutter * 2);
        return Center(
          child: SizedBox(
            width: canvasSize,
            height: canvasSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _ring(ringSize * 0.98, const Color(0xFF1B1B1B), 1),
                _ring(ringSize * 0.78, const Color(0xFF2B2015), 1.4),
                _ring(ringSize * 0.58, const Color(0xFF3B2A1B), 1.6),
                _ring(ringSize * 0.38, const Color(0xFF5D3A1B), 1.8),
                _centerCore(ringSize * 0.28),
                ..._buildRadialLabels(
                  radius: ringSize * 0.36,
                  labels: fixItems.take(6).toList(),
                  chipColor: const Color(0xFF1A1A1A),
                  textColor: const Color(0xFFE2C9B3),
                ),
                ..._buildRadialLabels(
                  radius: ringSize * 0.50,
                  labels: rays.map((ray) => ray.name).toList(),
                  chipColor: const Color(0xFF111111),
                  textColor: Colors.white,
                ),
                ..._buildRadialLabels(
                  radius: ringSize * 0.61,
                  labels: timeRays.map((ray) => ray.label).toList(),
                  chipColor: const Color(0xFFF59E0B),
                  textColor: const Color(0xFF111111),
                  maxChipWidth: 100,
                  angleOffset: -math.pi / 2.6,
                ),
                Positioned(
                  top: labelGutter + (ringSize * 0.13),
                  child: _ringLabel('Zeitstrahlen'),
                ),
                Positioned(
                  top: labelGutter + (ringSize * 0.28),
                  child: _ringLabel('Strahlen'),
                ),
                Positioned(
                  top: labelGutter + (ringSize * 0.43),
                  child: _ringLabel('Fixkreis'),
                ),
                Positioned(
                  bottom: labelGutter + (ringSize * 0.25),
                  child: _ringLabel('Orbit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _ring(double size, Color color, double strokeWidth) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: strokeWidth),
        gradient: RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.02),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _centerCore(double size) {
    final orbitText = secondaryProjects.isEmpty
        ? 'Heute ohne Nebenorbit'
        : secondaryProjects.map((project) => project.name).take(2).join(' · ');
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE47B38),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE47B38).withValues(alpha: 0.3),
            blurRadius: 36,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Kern',
            style: TextStyle(
              color: Color(0xFF20130D),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            primaryProject.name,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            orbitText,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF3D271C),
              fontSize: 11,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ringLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFAAAAAA),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  List<Widget> _buildRadialLabels({
    required double radius,
    required List<String> labels,
    required Color chipColor,
    required Color textColor,
    double maxChipWidth = 118,
    double angleOffset = -math.pi / 2,
  }) {
    final widgets = <Widget>[];
    final total = labels.length;
    for (var i = 0; i < total; i++) {
      final angle = angleOffset + (i * (2 * math.pi / total));
      final dx = math.cos(angle) * radius;
      final dy = math.sin(angle) * radius;
      widgets.add(
        Transform.translate(
          offset: Offset(dx, dy),
          child: Container(
            constraints: BoxConstraints(maxWidth: maxChipWidth),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: chipColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Text(
              labels[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}

class _TimeRay {
  const _TimeRay({
    required this.label,
    required this.title,
    required this.body,
  });

  final String label;
  final String title;
  final String body;
}

List<String> _buildFixItems(SonnenkompassStore store) {
  final fixedSlots =
      store.fixedSlots.take(2).map((slot) => slot.title).toList();
  return [
    'Arbeit',
    'Mahlzeiten',
    'Katzen',
    'Reset',
    _movementActivity(store.movementPlan.activityType),
    ...fixedSlots,
  ];
}

List<_TimeRay> _buildTimeRays(SonnenkompassStore store) {
  final morningMeetings = store.fixedSlots
      .where((slot) => slot.startTime.compareTo('12:00') < 0)
      .take(2)
      .map((slot) => slot.title)
      .join(' · ');
  final afternoonTask = store.mustDoTasks.isNotEmpty
      ? store.mustDoTasks.first.title
      : 'Fokusfenster';
  final eveningTask = store.optionalTasks.isNotEmpty
      ? store.optionalTasks.first.title
      : 'Review und Reset';

  return [
    _TimeRay(
      label: 'Vormittag',
      title: _workLabel(store.focusDay.workMode),
      body: morningMeetings.isEmpty
          ? 'Arbeitskern und feste Anker'
          : 'Arbeitskern mit $morningMeetings',
    ),
    _TimeRay(
      label: 'Nachmittag',
      title: 'Fokus / Orbit',
      body: afternoonTask,
    ),
    _TimeRay(
      label: 'Abend',
      title: _movementActivity(store.movementPlan.activityType),
      body: eveningTask,
    ),
  ];
}

String _workLabel(WorkMode mode) {
  switch (mode) {
    case WorkMode.homeOffice:
      return 'Homeoffice';
    case WorkMode.office:
      return 'Buero';
    case WorkMode.mixed:
      return 'Gemischt';
  }
}

String _energyLabel(EnergyLevel level) {
  switch (level) {
    case EnergyLevel.low:
      return 'Niedrig';
    case EnergyLevel.medium:
      return 'Mittel';
    case EnergyLevel.high:
      return 'Hoch';
  }
}

String _movementActivity(MovementActivityType type) =>
    type.toString().split('.').last;

String _movementStatus(MovementStatus status) {
  switch (status) {
    case MovementStatus.planned:
      return 'Geplant';
    case MovementStatus.booked:
      return 'Gebucht';
    case MovementStatus.done:
      return 'Erledigt';
    case MovementStatus.skipped:
      return 'Ausgelassen';
  }
}
