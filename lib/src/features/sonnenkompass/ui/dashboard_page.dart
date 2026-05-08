import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/models.dart';
import '../../../core/app_scope.dart';
import 'ui_helpers.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return buildPageScaffold(
      title: 'Sonnenkompass',
      subtitle:
          'Kernfokus, Orbit, Tagesausfuehrung und Review in einer echten Web-App-Struktur.',
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
          panel(
            'Heute im Kern',
            'Der aktiv gesetzte Hauptfokus mit realen Folgeaktionen.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.primaryProject.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  store.primaryProject.currentGoal,
                  style: const TextStyle(color: Color(0xFFAAAAAA), height: 1.4),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    pill('Arbeit ${_workLabel(store.focusDay.workMode)}'),
                    pill('Energie ${_energyLabel(store.focusDay.energyLevel)}'),
                    pill('Bewegung ${_movementStatus(store.movementPlan.status)}'),
                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton(
                      onPressed: () =>
                          context.go('/projects/${store.primaryProject.id}'),
                      child: const Text('Projekt oeffnen'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go('/rays/${store.primaryProject.rayId}'),
                      child: const Text('Zum Strahl'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 1000;
              final left = panel(
                'Orbit',
                'Nur wenige aktive Themen gleichzeitig.',
                Column(
                  children: [
                    _orbitCard('Sonnenkern', store.primaryProject.name,
                        store.primaryProject.currentGoal),
                    const SizedBox(height: 10),
                    ...store.secondaryProjects.map(
                      (project) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _orbitCard(
                          'Nebenfokus',
                          project.name,
                          project.currentGoal,
                        ),
                      ),
                    ),
                    _orbitCard(
                      'Bewegung',
                      _movementActivity(store.movementPlan.activityType),
                      '${store.movementPlan.venue} · ${_movementStatus(store.movementPlan.status)}',
                    ),
                  ],
                ),
              );
              final right = panel(
                'Naechste Schritte',
                'Muss heute passieren und sollte nicht im Dashboard enden.',
                Column(
                  children: [
                    ...store.mustDoTasks.map((task) => _taskTile(task, context)),
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
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFF59E0B))),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(color: Color(0xFFAAAAAA), height: 1.35)),
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
