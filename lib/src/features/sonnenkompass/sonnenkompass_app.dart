import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../domain/seed/seed_data.dart';
import 'ui/sonnenkompass_home_page.dart';

class SonnenkompassPrototypeApp extends StatefulWidget {
  const SonnenkompassPrototypeApp({super.key});

  @override
  State<SonnenkompassPrototypeApp> createState() =>
      _SonnenkompassPrototypeAppState();
}

class _SonnenkompassPrototypeAppState extends State<SonnenkompassPrototypeApp> {
  late String selectedRayId;
  late int selectedWeekday;
  late List<Project> projects;
  late List<Idea> ideas;
  late FocusDay focusDay;
  late MovementPlan movementPlan;
  late String primaryProjectId;
  late List<String> secondaryProjectIds;
  late List<DailyRoutineBlock> dailyRoutines;
  late List<RhythmTask> rhythmTasks;
  late List<FixedSlot> fixedSlots;
  final Set<String> completedRoutineIds = <String>{};
  final Set<String> completedRhythmTaskIds = <String>{};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedRayId = seedRays.first.id;
    selectedWeekday = now.weekday <= DateTime.friday ? now.weekday : DateTime.monday;
    projects = List<Project>.from(seedProjects);
    ideas = List<Idea>.from(seedIdeas);
    focusDay = seedFocusDay;
    movementPlan = seedMovementPlan;
    dailyRoutines = List<DailyRoutineBlock>.from(seedDailyRoutineBlocks);
    rhythmTasks = List<RhythmTask>.from(seedRhythmTasks);
    fixedSlots = List<FixedSlot>.from(seedFixedSlots);

    final primaryOrbit = seedOrbitItems.firstWhere(
      (item) => item.id == seedFocusDay.primaryOrbitItemId,
    );
    primaryProjectId = primaryOrbit.itemId;

    secondaryProjectIds = seedOrbitItems
        .where(
          (item) =>
              seedFocusDay.secondaryOrbitItemIds.contains(item.id) &&
              item.itemType == OrbitItemType.project,
        )
        .map((item) => item.itemId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedRay = seedRays.firstWhere((ray) => ray.id == selectedRayId);
    final selectedRayProjects =
        projects.where((project) => project.rayId == selectedRay.id).toList();
    final selectedRayIdeas =
        ideas.where((idea) => idea.rayId == selectedRay.id).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final primaryProject =
        projects.firstWhere((project) => project.id == primaryProjectId);
    final secondaryProjects = projects
        .where((project) => secondaryProjectIds.contains(project.id))
        .toList();

    return SonnenkompassHomePage(
      profile: seedUserProfile,
      focusDay: focusDay,
      movementPlan: movementPlan,
      rays: seedRays,
      projects: projects,
      selectedRay: selectedRay,
      selectedRayProjects: selectedRayProjects,
      selectedRayIdeas: selectedRayIdeas,
      primaryProject: primaryProject,
      secondaryProjects: secondaryProjects,
      selectedWeekday: selectedWeekday,
      fixedSlots: fixedSlots,
      dailyRoutines: dailyRoutines,
      rhythmTasks: rhythmTasks,
      completedRoutineIds: completedRoutineIds,
      completedRhythmTaskIds: completedRhythmTaskIds,
      onSelectRay: (ray) => setState(() => selectedRayId = ray.id),
      onSetPrimaryProject: _setPrimaryProject,
      onToggleSecondaryProject: _toggleSecondaryProject,
      onWorkModeChanged: _setWorkMode,
      onEnergyChanged: _setEnergyLevel,
      onMovementStatusChanged: _setMovementStatus,
      onMovementActivityChanged: _setMovementActivity,
      onSelectedWeekdayChanged: _setWeekday,
      onToggleRoutineDone: _toggleRoutineDone,
      onToggleRhythmTaskDone: _toggleRhythmTaskDone,
      onAddIdea: _addIdea,
    );
  }

  void _setPrimaryProject(Project project) {
    setState(() {
      primaryProjectId = project.id;
      secondaryProjectIds.remove(project.id);
      _touchFocusDay();
    });
  }

  void _toggleSecondaryProject(Project project) {
    setState(() {
      if (project.id == primaryProjectId) return;
      if (secondaryProjectIds.contains(project.id)) {
        secondaryProjectIds.remove(project.id);
      } else {
        if (secondaryProjectIds.length >= 2) {
          secondaryProjectIds.removeAt(0);
        }
        secondaryProjectIds.add(project.id);
      }
      _touchFocusDay();
    });
  }

  void _setWorkMode(WorkMode mode) {
    setState(() {
      focusDay = _copyFocusDay(workMode: mode);
    });
  }

  void _setEnergyLevel(EnergyLevel level) {
    setState(() {
      focusDay = _copyFocusDay(energyLevel: level);
      movementPlan = MovementPlan(
        id: movementPlan.id,
        date: movementPlan.date,
        energyLevel: level,
        venue: movementPlan.venue,
        activityType: _defaultActivityForEnergy(level),
        plannedStart: movementPlan.plannedStart,
        plannedDurationMinutes: movementPlan.plannedDurationMinutes,
        status: movementPlan.status,
        bookingSource: movementPlan.bookingSource,
        notes: movementPlan.notes,
        createdAt: movementPlan.createdAt,
        updatedAt: DateTime.now(),
      );
    });
  }

  void _setMovementStatus(MovementStatus status) {
    setState(() {
      movementPlan = MovementPlan(
        id: movementPlan.id,
        date: movementPlan.date,
        energyLevel: movementPlan.energyLevel,
        venue: movementPlan.venue,
        activityType: movementPlan.activityType,
        plannedStart: movementPlan.plannedStart,
        plannedDurationMinutes: movementPlan.plannedDurationMinutes,
        status: status,
        bookingSource: movementPlan.bookingSource,
        notes: movementPlan.notes,
        createdAt: movementPlan.createdAt,
        updatedAt: DateTime.now(),
      );
    });
  }

  void _setMovementActivity(MovementActivityType activity) {
    setState(() {
      movementPlan = MovementPlan(
        id: movementPlan.id,
        date: movementPlan.date,
        energyLevel: movementPlan.energyLevel,
        venue: movementPlan.venue,
        activityType: activity,
        plannedStart: movementPlan.plannedStart,
        plannedDurationMinutes: movementPlan.plannedDurationMinutes,
        status: movementPlan.status,
        bookingSource: movementPlan.bookingSource,
        notes: movementPlan.notes,
        createdAt: movementPlan.createdAt,
        updatedAt: DateTime.now(),
      );
    });
  }

  void _setWeekday(int weekday) {
    setState(() {
      selectedWeekday = weekday;
    });
  }

  void _toggleRoutineDone(String routineId) {
    setState(() {
      if (completedRoutineIds.contains(routineId)) {
        completedRoutineIds.remove(routineId);
      } else {
        completedRoutineIds.add(routineId);
      }
    });
  }

  void _toggleRhythmTaskDone(String taskId) {
    setState(() {
      if (completedRhythmTaskIds.contains(taskId)) {
        completedRhythmTaskIds.remove(taskId);
      } else {
        completedRhythmTaskIds.add(taskId);
      }
    });
  }

  void _addIdea({
    required String title,
    required String summary,
    required MonetizationPotential monetizationPotential,
  }) {
    final now = DateTime.now();
    final newIdea = Idea(
      id: 'idea-${now.microsecondsSinceEpoch}',
      rayId: selectedRayId,
      projectId: null,
      title: title,
      summary: summary,
      description: summary,
      status: IdeaStatus.captured,
      priority: PriorityLevel.medium,
      confidence: 0.6,
      sourceType: IdeaSourceType.manualText,
      sourceText: '$title\n$summary',
      capturedAt: now,
      suggestedNextStep:
          'Schaerfen und bewusst pruefen, ob es in den Orbit soll.',
      activationReadiness: ActivationReadiness.needsClarification,
      monetizationPotential: monetizationPotential,
      timeToFirstVersion: TimeToFirstVersion.oneWeek,
      proofOfOutput: ProofOfOutputType.none,
      tags: const [],
      createdByAi: false,
      aiNotes: '',
      createdAt: now,
      updatedAt: now,
    );

    setState(() {
      ideas = [newIdea, ...ideas];
    });
  }

  void _touchFocusDay() {
    focusDay = _copyFocusDay();
  }

  FocusDay _copyFocusDay({
    WorkMode? workMode,
    EnergyLevel? energyLevel,
  }) {
    return FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: workMode ?? focusDay.workMode,
      energyLevel: energyLevel ?? focusDay.energyLevel,
      primaryOrbitItemId: 'primary-$primaryProjectId',
      secondaryOrbitItemIds: [
        ...secondaryProjectIds.map((id) => 'secondary-$id'),
        'movement-slot',
      ],
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  MovementActivityType _defaultActivityForEnergy(EnergyLevel level) {
    switch (level) {
      case EnergyLevel.low:
        return MovementActivityType.yinYoga;
      case EnergyLevel.medium:
        return MovementActivityType.pilates;
      case EnergyLevel.high:
        return MovementActivityType.beachVolleyball;
    }
  }
}

