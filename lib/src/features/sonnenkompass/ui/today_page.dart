import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../core/app_scope.dart';
import 'ui_helpers.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    final todaySlots = store.fixedSlots
        .where((slot) => slot.dayOfWeek == store.focusDay.date.weekday)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return buildPageScaffold(
      title: 'Heute',
      subtitle:
          'Tagesausfuehrung mit Muss-Aufgaben, optionalen Aufgaben und klaren Routinen.',
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 1000;
              final left = panel(
                'Muss heute passieren',
                'Diese Aufgaben definieren den Tag.',
                Column(
                  children: store.mustDoTasks
                      .map((task) => _taskCard(context, task, highlight: true))
                      .toList(),
                ),
              );
              final right = panel(
                'Optional wenn Luft da ist',
                'Nur falls der Kern steht.',
                Column(
                  children: store.optionalTasks
                      .map((task) => _taskCard(context, task))
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
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 1000;
              final left = panel(
                'Block-Stundenplan',
                'Kalenderanker statt diffuser Tagesoffenheit.',
                Column(
                  children: [
                    for (final slot in todaySlots)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('${slot.startTime} - ${slot.endTime}'),
                        subtitle: Text(slot.title),
                      ),
                  ],
                ),
              );
              final right = panel(
                'Pflege- und Rhythmuslogik',
                'Was den Tag stabil haelt.',
                Column(
                  children: [
                    ...store.dailyRoutines.map(
                      (routine) => CheckboxListTile(
                        value: store.completedRoutineIds.contains(routine.id),
                        onChanged: (_) => store.toggleRoutineDone(routine.id),
                        contentPadding: EdgeInsets.zero,
                        title: Text(routine.name),
                        subtitle: Text(
                          [
                            if (routine.defaultStartTime != null)
                              routine.defaultStartTime!,
                            '${routine.defaultDurationMinutes} Min',
                            routine.notes ?? '',
                          ].where((part) => part.isNotEmpty).join(' · '),
                        ),
                      ),
                    ),
                    const Divider(),
                    ...store.rhythmTasks.map(
                      (task) => CheckboxListTile(
                        value: store.completedRhythmTaskIds.contains(task.id),
                        onChanged: (_) => store.toggleRhythmTaskDone(task.id),
                        contentPadding: EdgeInsets.zero,
                        title: Text(task.title),
                        subtitle: Text(
                          'Alle ${task.frequencyDays} Tage · ${task.defaultWindow}',
                        ),
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

  Widget _taskCard(BuildContext context, Task task, {bool highlight = false}) {
    final store = AppScope.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFF13100D) : const Color(0xFF101010),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: highlight ? const Color(0xFF352616) : const Color(0xFF1D1B18),
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: task.status == TaskStatus.done,
            onChanged: (_) => store.toggleTaskDone(task.id),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF4E7D7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: const TextStyle(color: Color(0xFF9D9387)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
