import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';

class SonnenkompassHomePage extends StatelessWidget {
  const SonnenkompassHomePage({
    required this.profile,
    required this.focusDay,
    required this.movementPlan,
    required this.rays,
    required this.projects,
    required this.selectedRay,
    required this.selectedRayProjects,
    required this.selectedRayIdeas,
    required this.primaryProject,
    required this.secondaryProjects,
    required this.selectedWeekday,
    required this.fixedSlots,
    required this.dailyRoutines,
    required this.rhythmTasks,
    required this.completedRoutineIds,
    required this.completedRhythmTaskIds,
    required this.onSelectRay,
    required this.onSetPrimaryProject,
    required this.onToggleSecondaryProject,
    required this.onWorkModeChanged,
    required this.onEnergyChanged,
    required this.onMovementStatusChanged,
    required this.onMovementActivityChanged,
    required this.onSelectedWeekdayChanged,
    required this.onToggleRoutineDone,
    required this.onToggleRhythmTaskDone,
    required this.onAddIdea,
    super.key,
  });

  final UserProfile profile;
  final FocusDay focusDay;
  final MovementPlan movementPlan;
  final List<Ray> rays;
  final List<Project> projects;
  final Ray selectedRay;
  final List<Project> selectedRayProjects;
  final List<Idea> selectedRayIdeas;
  final Project primaryProject;
  final List<Project> secondaryProjects;
  final int selectedWeekday;
  final List<FixedSlot> fixedSlots;
  final List<DailyRoutineBlock> dailyRoutines;
  final List<RhythmTask> rhythmTasks;
  final Set<String> completedRoutineIds;
  final Set<String> completedRhythmTaskIds;
  final ValueChanged<Ray> onSelectRay;
  final ValueChanged<Project> onSetPrimaryProject;
  final ValueChanged<Project> onToggleSecondaryProject;
  final ValueChanged<WorkMode> onWorkModeChanged;
  final ValueChanged<EnergyLevel> onEnergyChanged;
  final ValueChanged<MovementStatus> onMovementStatusChanged;
  final ValueChanged<MovementActivityType> onMovementActivityChanged;
  final ValueChanged<int> onSelectedWeekdayChanged;
  final ValueChanged<String> onToggleRoutineDone;
  final ValueChanged<String> onToggleRhythmTaskDone;
  final void Function({
    required String title,
    required String summary,
    required MonetizationPotential monetizationPotential,
  }) onAddIdea;

  @override
  Widget build(BuildContext context) {
    final todaySlots = fixedSlots
        .where((slot) => slot.dayOfWeek == selectedWeekday)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _pill('Rammer Sonnenkompass MVP', dark: true),
                      _pill(profile.defaultMovementVenue),
                      _pill('3 Mahlzeiten wenn moeglich'),
                      _pill('1 Kern + max. 2 Nebenstrahlen'),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _heroSection(),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final stacked = constraints.maxWidth < 1080;
                        final left = _panel(
                          'Block-Stundenplan',
                          'Kalenderanker, Lebenspflege, Fokus und Erholung als ein Geruest.',
                          _blockPlan(todaySlots),
                        );
                        final right = _panel(
                          'Wochenmuster',
                          'Dein Standard aus den gezeigten Screenshots plus Routine-Rhythmus.',
                          _weekPattern(),
                        );
                        if (stacked) {
                          return Column(
                            children: [left, const SizedBox(height: 18), right],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 7, child: left),
                            const SizedBox(width: 18),
                            Expanded(flex: 5, child: right),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final stacked = constraints.maxWidth < 1080;
                        final left = _panel(
                          'Pflege- und Rhythmuslogik',
                          'Diese Dinge halten dein System stabil und sollen nicht unsichtbar werden.',
                          _careAndRhythm(),
                        );
                        final right = _panel(
                          'Orbit',
                          'Der Sonnenkompass bleibt aktiv: ein Kernprojekt, zwei Nebenprojekte, Bewegung als Pflichtanker.',
                          _orbitSection(),
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
                            Expanded(flex: 6, child: right),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final stacked = constraints.maxWidth < 1080;
                        final left = _panel(
                          selectedRay.name,
                          selectedRay.description,
                          _rayDetail(context),
                        );
                        final right = _panel(
                          'Monetization Layer',
                          'Sortierung nach Lieferfaehigkeit statt nur nach Reiz.',
                          _monetizationSection(),
                        );
                        if (stacked) {
                          return Column(
                            children: [left, const SizedBox(height: 18), right],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 7, child: left),
                            const SizedBox(width: 18),
                            Expanded(flex: 5, child: right),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  Widget _heroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        border: Border.all(color: const Color(0xFF1E1E1E)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final left = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Heute im Kern',
                style: TextStyle(
                  color: Color(0xFFF59E0B),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                primaryProject.name,
                style: const TextStyle(
                  fontSize: 38,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                primaryProject.currentGoal,
                style: const TextStyle(
                  color: Color(0xFFAAAAAA),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _pill('Work ${_workLabel(focusDay.workMode)}'),
                  _pill('Energy ${_energyLabel(focusDay.energyLevel)}'),
                  _pill('Proof ${_proofLabel(primaryProject.proofOfOutput)}'),
                ],
              ),
            ],
          );

          final right = Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFAF4),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tagesmodus',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2A1B13),
                  ),
                ),
                const SizedBox(height: 12),
                _chips<WorkMode>(
                  focusDay.workMode,
                  WorkMode.values,
                  _workLabel,
                  onWorkModeChanged,
                ),
                const SizedBox(height: 12),
                _chips<EnergyLevel>(
                  focusDay.energyLevel,
                  EnergyLevel.values,
                  _energyLabel,
                  onEnergyChanged,
                ),
                const SizedBox(height: 16),
                Text(
                  'Bewegung: ${_movementLabel(movementPlan.activityType)}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<MovementActivityType>(
                  value: movementPlan.activityType,
                  decoration: const InputDecoration(
                    labelText: 'Aktivitaet ausser Haus',
                  ),
                  items: const [
                    MovementActivityType.yinYoga,
                    MovementActivityType.pilates,
                    MovementActivityType.barre,
                    MovementActivityType.massage,
                    MovementActivityType.beachVolleyball,
                    MovementActivityType.basketball,
                  ]
                      .map(
                        (activity) => DropdownMenuItem(
                          value: activity,
                          child: Text(_movementLabel(activity)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) onMovementActivityChanged(value);
                  },
                ),
                const SizedBox(height: 12),
                _chips<MovementStatus>(
                  movementPlan.status,
                  MovementStatus.values,
                  _movementStatusLabel,
                  onMovementStatusChanged,
                ),
              ],
            ),
          );

          if (constraints.maxWidth < 980) {
            return Column(
              children: [left, const SizedBox(height: 18), right],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: left),
              const SizedBox(width: 18),
              Expanded(flex: 2, child: right),
            ],
          );
        },
      ),
    );
  }

  Widget _blockPlan(List<FixedSlot> todaySlots) {
    final entries = <_BlockEntry>[
      const _BlockEntry(
        time: '07:50',
        title: 'Start / Hygiene',
        detail: 'Morgenpflege, Wasser, Katzen, Wohnung kurz stabilisieren.',
      ),
      const _BlockEntry(
        time: '08:30',
        title: 'Fruehstueck',
        detail: 'Erste Mahlzeit ohne Tasking, wenn moeglich.',
      ),
      _BlockEntry(
        time: '09:30-12:30',
        title: 'Vormittags-Arbeitskern',
        detail: todaySlots.isEmpty
            ? 'Arbeitsfokus mit taeglichem Daily-Anker.'
            : 'Arbeitsfokus mit: ${todaySlots.map((slot) => '${slot.startTime} ${slot.title}').join(' · ')}',
      ),
      const _BlockEntry(
        time: '13:00',
        title: 'Mittag',
        detail: 'Echter Mittagsanker statt heimlichem Durcharbeiten.',
      ),
      const _BlockEntry(
        time: '13:45-16:30',
        title: 'Nachmittags-Fokus / Meetings',
        detail: 'Meetings aus dem Wochenmuster oder Sonnenkern, wenn Luft da ist.',
      ),
      _BlockEntry(
        time: '17:30-19:00',
        title: 'Rhythmusfenster',
        detail:
            '${_movementLabel(movementPlan.activityType)} ausser Haus oder Waesche / Reset je nach Rhythmus.',
      ),
      const _BlockEntry(
        time: '19:30',
        title: 'Abendessen',
        detail: 'Dritte Mahlzeit als Runterfahranker.',
      ),
      const _BlockEntry(
        time: '20:20-20:45',
        title: 'Haushaltsreset',
        detail: 'Geschirr, Boden, Aufraeumen, Katzen, keine Eskalation.',
      ),
      const _BlockEntry(
        time: '21:00-22:15',
        title: 'Leichter Abendblock',
        detail:
            'Optional: Sonnenkern weiterziehen, Review oder kleiner Markt-/Projekt-Schritt.',
      ),
      const _BlockEntry(
        time: '22:20',
        title: 'Abendhygiene / Schlafvorbereitung',
        detail: 'System ruhig schliessen statt weiter offen lassen.',
      ),
    ];

    return Column(
      children: entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        entry.time,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8C5225),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            entry.detail,
                            style: const TextStyle(
                              color: Color(0xFF6B5545),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _weekPattern() {
    const weekdays = <int>[
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: weekdays
              .map(
                (weekday) => ChoiceChip(
                  selected: selectedWeekday == weekday,
                  label: Text(_weekdayLabel(weekday)),
                  onSelected: (_) => onSelectedWeekdayChanged(weekday),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 14),
        for (final weekday in weekdays)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: weekday == selectedWeekday
                    ? const Color(0xFFFFE7D1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _weekdayLabel(weekday),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (final slot in fixedSlots.where((slot) => slot.dayOfWeek == weekday))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${slot.startTime}-${slot.endTime}  ${slot.title}',
                        style: const TextStyle(
                          color: Color(0xFF6B5545),
                          height: 1.3,
                        ),
                      ),
                    ),
                  if (fixedSlots.where((slot) => slot.dayOfWeek == weekday).isEmpty)
                    const Text(
                      'Keine besonderen Zusatztermine ausser Daily.',
                      style: TextStyle(color: Color(0xFF6B5545)),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _careAndRhythm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Taegliche Pflegeanker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        for (final routine in dailyRoutines)
          CheckboxListTile(
            value: completedRoutineIds.contains(routine.id),
            onChanged: (_) => onToggleRoutineDone(routine.id),
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(routine.name),
            subtitle: Text(
              [
                if (routine.defaultStartTime != null) routine.defaultStartTime!,
                '${routine.defaultDurationMinutes} Min',
                routine.notes ?? '',
              ].where((part) => part.isNotEmpty).join(' · '),
            ),
          ),
        const SizedBox(height: 18),
        const Text(
          'Rhythmusaufgaben',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        for (final task in rhythmTasks)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: completedRhythmTaskIds.contains(task.id),
                  onChanged: (_) => onToggleRhythmTaskDone(task.id),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Alle ${task.frequencyDays} Tage · ${task.defaultWindow} · ${task.durationMinutes} Min',
                        style: const TextStyle(color: Color(0xFF6B5545)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.notes,
                        style: const TextStyle(
                          color: Color(0xFF6B5545),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _orbitSection() {
    return Column(
      children: [
        _orbitCard(
          label: 'Sonnenkern',
          title: primaryProject.name,
          body: primaryProject.currentGoal,
          accent: const Color(0xFFE47B38),
        ),
        const SizedBox(height: 12),
        for (final project in secondaryProjects)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _orbitCard(
              label: 'Nebenstrahl',
              title: project.name,
              body: project.currentGoal,
              accent: const Color(0xFF8A5730),
            ),
          ),
        _orbitCard(
          label: 'Bewegung',
          title: _movementLabel(movementPlan.activityType),
          body:
              '${movementPlan.venue} · ${_movementStatusLabel(movementPlan.status)}',
          accent: const Color(0xFF2F7A6C),
        ),
      ],
    );
  }

  Widget _rayDetail(BuildContext context) {
    final secondaryIds = secondaryProjects.map((project) => project.id).toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Projekte im Strahl',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        if (selectedRayProjects.isEmpty)
          const Text('Noch keine Projekte in diesem Strahl.')
        else
          ...selectedRayProjects.map(
            (project) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFAF5),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _statusChip(_projectStatusLabel(project.status)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.currentGoal,
                      style: const TextStyle(
                        color: Color(0xFF6B5545),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _pill('Money ${_monetizationLabel(project.monetizationPotential)}'),
                        _pill('TTFV ${_ttfvLabel(project.timeToFirstVersion)}'),
                        _pill('Proof ${_proofLabel(project.proofOfOutput)}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        FilledButton(
                          onPressed: () => onSetPrimaryProject(project),
                          style: FilledButton.styleFrom(
                            backgroundColor: project.id == primaryProject.id
                                ? const Color(0xFF20130D)
                                : const Color(0xFFE47B38),
                          ),
                          child: Text(
                            project.id == primaryProject.id
                                ? 'Aktueller Kern'
                                : 'Zum Kern machen',
                          ),
                        ),
                        OutlinedButton(
                          onPressed: project.id == primaryProject.id
                              ? null
                              : () => onToggleSecondaryProject(project),
                          child: Text(
                            secondaryIds.contains(project.id)
                                ? 'Aus Orbit entfernen'
                                : 'In Orbit setzen',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Ideen-Backlog',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            FilledButton(
              onPressed: () => _showIdeaDialog(context),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF20130D),
              ),
              child: const Text('Idee hinzufuegen'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (selectedRayIdeas.isEmpty)
          const Text('Noch keine Ideen in diesem Strahl.')
        else
          ...selectedRayIdeas.map(
            (idea) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                title: Text(idea.title),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${idea.summary}\nNaechster Schritt: ${idea.suggestedNextStep}',
                    style: const TextStyle(height: 1.4),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _ideaStatusLabel(idea.status),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE47B38),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_ttfvLabel(idea.timeToFirstVersion)} · ${_monetizationLabel(idea.monetizationPotential)}',
                      style: const TextStyle(color: Color(0xFF6B5545)),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _monetizationSection() {
    final sorted = [...projects]
      ..sort((a, b) {
        final money = b.monetizationPotential.index
            .compareTo(a.monetizationPotential.index);
        if (money != 0) return money;
        return a.timeToFirstVersion.index.compareTo(b.timeToFirstVersion.index);
      });

    return Column(
      children: sorted
          .map(
            (project) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF20130D),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.currentGoal,
                      style: const TextStyle(
                        color: Color(0xFFF1E0D1),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _pill(
                          'Money ${_monetizationLabel(project.monetizationPotential)}',
                          dark: true,
                        ),
                        _pill(
                          'TTFV ${_ttfvLabel(project.timeToFirstVersion)}',
                          dark: true,
                        ),
                        _pill(
                          'Proof ${_proofLabel(project.proofOfOutput)}',
                          dark: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Future<void> _showIdeaDialog(BuildContext context) async {
    final title = TextEditingController();
    final summary = TextEditingController();
    var monetization = MonetizationPotential.medium;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Neue Idee im Strahl'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: title,
                      decoration: const InputDecoration(labelText: 'Titel'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: summary,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Kurzbeschreibung',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<MonetizationPotential>(
                      value: monetization,
                      decoration: const InputDecoration(
                        labelText: 'Monetarisierung',
                      ),
                      items: MonetizationPotential.values
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(_monetizationLabel(value)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => monetization = value);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Abbrechen'),
                ),
                FilledButton(
                  onPressed: () {
                    final trimmedTitle = title.text.trim();
                    final trimmedSummary = summary.text.trim();
                    if (trimmedTitle.isEmpty || trimmedSummary.isEmpty) return;
                    onAddIdea(
                      title: trimmedTitle,
                      summary: trimmedSummary,
                      monetizationPotential: monetization,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Speichern'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _BlockEntry {
  const _BlockEntry({
    required this.time,
    required this.title,
    required this.detail,
  });

  final String time;
  final String title;
  final String detail;
}

Widget _panel(String title, String subtitle, Widget child) {
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
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

Widget _pill(String label, {bool dark = false}) {
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

Widget _statusChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFF111111),
      border: Border.all(color: const Color(0xFF222222)),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFF8C5225),
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _orbitCard({
  required String label,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF111111),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: accent.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w700, color: accent),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(color: Color(0xFFAAAAAA), height: 1.4),
        ),
      ],
    ),
  );
}

Widget _chips<T>(
  T selectedValue,
  List<T> values,
  String Function(T value) labelBuilder,
  ValueChanged<T> onChanged,
) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: values
        .map(
          (value) => ChoiceChip(
            selected: value == selectedValue,
            label: Text(labelBuilder(value)),
            onSelected: (_) => onChanged(value),
          ),
        )
        .toList(),
  );
}

String _weekdayLabel(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Montag';
    case DateTime.tuesday:
      return 'Dienstag';
    case DateTime.wednesday:
      return 'Mittwoch';
    case DateTime.thursday:
      return 'Donnerstag';
    case DateTime.friday:
      return 'Freitag';
    default:
      return 'Tag';
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
      return 'Low';
    case EnergyLevel.medium:
      return 'Medium';
    case EnergyLevel.high:
      return 'High';
  }
}

String _movementLabel(MovementActivityType type) {
  switch (type) {
    case MovementActivityType.yinYoga:
      return 'Yin Yoga';
    case MovementActivityType.meditation:
      return 'Meditation';
    case MovementActivityType.soundBath:
      return 'Sound Bath';
    case MovementActivityType.mobility:
      return 'Mobility';
    case MovementActivityType.barre:
      return 'Barre';
    case MovementActivityType.pilates:
      return 'Pilates';
    case MovementActivityType.gymLight:
      return 'Light Gym';
    case MovementActivityType.beachVolleyball:
      return 'Beachvolleyball';
    case MovementActivityType.basketball:
      return 'Basketball';
    case MovementActivityType.squash:
      return 'Squash';
    case MovementActivityType.tennis:
      return 'Tennis';
    case MovementActivityType.walk:
      return 'Walk';
    case MovementActivityType.bike:
      return 'Bike';
    case MovementActivityType.massage:
      return 'Massage';
  }
}

String _movementStatusLabel(MovementStatus status) {
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

String _projectStatusLabel(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.backlog:
      return 'Backlog';
    case ProjectStatus.ready:
      return 'Ready';
    case ProjectStatus.active:
      return 'Aktiv';
    case ProjectStatus.paused:
      return 'Pausiert';
    case ProjectStatus.blocked:
      return 'Blockiert';
    case ProjectStatus.done:
      return 'Fertig';
    case ProjectStatus.archived:
      return 'Archiv';
  }
}

String _ideaStatusLabel(IdeaStatus status) {
  switch (status) {
    case IdeaStatus.captured:
      return 'Captured';
    case IdeaStatus.clarified:
      return 'Clarified';
    case IdeaStatus.parked:
      return 'Parked';
    case IdeaStatus.candidate:
      return 'Candidate';
    case IdeaStatus.active:
      return 'Active';
    case IdeaStatus.done:
      return 'Done';
    case IdeaStatus.archived:
      return 'Archived';
    case IdeaStatus.discarded:
      return 'Discarded';
  }
}

String _monetizationLabel(MonetizationPotential value) {
  switch (value) {
    case MonetizationPotential.none:
      return 'None';
    case MonetizationPotential.unclear:
      return 'Unclear';
    case MonetizationPotential.low:
      return 'Low';
    case MonetizationPotential.medium:
      return 'Medium';
    case MonetizationPotential.high:
      return 'High';
  }
}

String _ttfvLabel(TimeToFirstVersion value) {
  switch (value) {
    case TimeToFirstVersion.oneDay:
      return '1d';
    case TimeToFirstVersion.threeDays:
      return '3d';
    case TimeToFirstVersion.oneWeek:
      return '1w';
    case TimeToFirstVersion.twoWeeks:
      return '2w';
    case TimeToFirstVersion.longer:
      return 'Later';
  }
}

String _proofLabel(ProofOfOutputType value) {
  switch (value) {
    case ProofOfOutputType.none:
      return 'None';
    case ProofOfOutputType.prototype:
      return 'Prototype';
    case ProofOfOutputType.shippedFeature:
      return 'Shipped';
    case ProofOfOutputType.landingPage:
      return 'Landing';
    case ProofOfOutputType.firstUsers:
      return 'Users';
    case ProofOfOutputType.firstRevenue:
      return 'Revenue';
    case ProofOfOutputType.paidPilot:
      return 'Pilot';
  }
}

