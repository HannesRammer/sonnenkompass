import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/models.dart';
import '../../domain/seed/seed_data.dart';

const _storageKey = 'sonnenkompass_state_v1';

class SonnenkompassStore extends ChangeNotifier {
  SonnenkompassStore._({
    required this.projects,
    required this.ideas,
    required this.tasks,
    required this.orbitItems,
    required this.focusDay,
    required this.movementPlan,
    required this.completedRoutineIds,
    required this.completedRhythmTaskIds,
  });

  factory SonnenkompassStore.seeded() {
    return SonnenkompassStore._(
      projects: List<Project>.from(seedProjects),
      ideas: List<Idea>.from(seedIdeas),
      tasks: List<Task>.from(seedTasks),
      orbitItems: List<OrbitItem>.from(seedOrbitItems),
      focusDay: seedFocusDay,
      movementPlan: seedMovementPlan,
      completedRoutineIds: <String>{},
      completedRhythmTaskIds: <String>{},
    );
  }

  static Future<SonnenkompassStore> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return SonnenkompassStore.seeded();
    }

    final json = jsonDecode(raw) as Map<String, dynamic>;
    return SonnenkompassStore._(
      projects: (json['projects'] as List<dynamic>)
          .map((item) => Project.fromJson(item as Map<String, dynamic>))
          .toList(),
      ideas: (json['ideas'] as List<dynamic>)
          .map((item) => Idea.fromJson(item as Map<String, dynamic>))
          .toList(),
      tasks: (json['tasks'] as List<dynamic>)
          .map((item) => Task.fromJson(item as Map<String, dynamic>))
          .toList(),
      orbitItems: (json['orbitItems'] as List<dynamic>)
          .map((item) => OrbitItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      focusDay: FocusDay.fromJson(json['focusDay'] as Map<String, dynamic>),
      movementPlan: MovementPlan.fromJson(
        json['movementPlan'] as Map<String, dynamic>,
      ),
      completedRoutineIds:
          (json['completedRoutineIds'] as List<dynamic>).cast<String>().toSet(),
      completedRhythmTaskIds:
          (json['completedRhythmTaskIds'] as List<dynamic>).cast<String>().toSet(),
    );
  }

  List<Project> projects;
  List<Idea> ideas;
  List<Task> tasks;
  List<OrbitItem> orbitItems;
  FocusDay focusDay;
  MovementPlan movementPlan;
  Set<String> completedRoutineIds;
  Set<String> completedRhythmTaskIds;

  List<Ray> get rays => seedRays;
  List<DailyRoutineBlock> get dailyRoutines => seedDailyRoutineBlocks;
  List<RhythmTask> get rhythmTasks => seedRhythmTasks;
  List<FixedSlot> get fixedSlots => seedFixedSlots;
  UserProfile get profile => seedUserProfile;

  Project get primaryProject =>
      projectById(primaryOrbitItem.itemId)!;

  OrbitItem get primaryOrbitItem =>
      orbitItems.firstWhere((item) => item.id == focusDay.primaryOrbitItemId);

  List<Project> get secondaryProjects => focusDay.secondaryOrbitItemIds
      .map(orbitItemById)
      .whereType<OrbitItem>()
      .where((item) => item.itemType == OrbitItemType.project)
      .map((item) => projectById(item.itemId))
      .whereType<Project>()
      .toList();

  List<Task> get mustDoTasks => focusDay.mustDoTaskIds
      .map(taskById)
      .whereType<Task>()
      .toList();

  List<Task> get optionalTasks => focusDay.optionalTaskIds
      .map(taskById)
      .whereType<Task>()
      .toList();

  Ray rayById(String id) => rays.firstWhere((ray) => ray.id == id);

  Project? projectById(String id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }

  Idea? ideaById(String id) {
    for (final idea in ideas) {
      if (idea.id == id) return idea;
    }
    return null;
  }

  Task? taskById(String id) {
    for (final task in tasks) {
      if (task.id == id) return task;
    }
    return null;
  }

  OrbitItem? orbitItemById(String id) {
    for (final item in orbitItems) {
      if (item.id == id) return item;
    }
    return null;
  }

  List<Project> projectsForRay(String rayId) =>
      projects.where((project) => project.rayId == rayId).toList();

  List<Idea> ideasForRay(String rayId) =>
      ideas.where((idea) => idea.rayId == rayId).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  List<Task> tasksForRay(String rayId) =>
      tasks.where((task) => task.rayId == rayId).toList();

  List<Task> tasksForProject(String projectId) =>
      tasks.where((task) => task.projectId == projectId).toList();

  Future<void> setPrimaryProject(String projectId) async {
    final previousPrimary = primaryOrbitItem;
    final existing = orbitItems.where((item) => item.itemId == projectId).firstWhere(
          (item) => item.role == OrbitRole.primaryFocus,
          orElse: () => OrbitItem(
            id: 'orbit-primary-$projectId',
            itemType: OrbitItemType.project,
            itemId: projectId,
            role: OrbitRole.primaryFocus,
            focusDate: focusDay.date,
            reason: 'Aktiver Kernfokus im Sonnenkompass.',
            activatedAt: DateTime.now(),
            createdAt: DateTime.now(),
          ),
        );

    orbitItems = orbitItems
        .where((item) => item.id != previousPrimary.id && item.itemId != projectId)
        .toList();
    orbitItems.insert(
      0,
      OrbitItem(
        id: existing.id,
        itemType: OrbitItemType.project,
        itemId: projectId,
        role: OrbitRole.primaryFocus,
        focusDate: focusDay.date,
        reason: existing.reason,
        activatedAt: existing.activatedAt,
        createdAt: existing.createdAt,
      ),
    );

    final secondaryIds = focusDay.secondaryOrbitItemIds
        .where((id) => orbitItemById(id)?.itemId != projectId)
        .toList();

    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: focusDay.workMode,
      energyLevel: focusDay.energyLevel,
      primaryOrbitItemId: existing.id,
      secondaryOrbitItemIds: secondaryIds,
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Future<void> toggleSecondaryProject(String projectId) async {
    if (primaryProject.id == projectId) return;

    final existingSecondaryIds = focusDay.secondaryOrbitItemIds
        .where((id) => orbitItemById(id)?.itemType == OrbitItemType.project)
        .toList();
    final existingOrbitItemId = existingSecondaryIds.firstWhere(
      (id) => orbitItemById(id)?.itemId == projectId,
      orElse: () => '',
    );

    if (existingOrbitItemId.isNotEmpty) {
      focusDay = FocusDay(
        id: focusDay.id,
        date: focusDay.date,
        workMode: focusDay.workMode,
        energyLevel: focusDay.energyLevel,
        primaryOrbitItemId: focusDay.primaryOrbitItemId,
        secondaryOrbitItemIds:
            focusDay.secondaryOrbitItemIds.where((id) => id != existingOrbitItemId).toList(),
        movementPlanId: focusDay.movementPlanId,
        mustDoTaskIds: focusDay.mustDoTaskIds,
        optionalTaskIds: focusDay.optionalTaskIds,
        dailyNote: focusDay.dailyNote,
        distractionLog: focusDay.distractionLog,
        dayReview: focusDay.dayReview,
        createdAt: focusDay.createdAt,
        updatedAt: DateTime.now(),
      );
      orbitItems = orbitItems.where((item) => item.id != existingOrbitItemId).toList();
      await _commit();
      return;
    }

    final newOrbitItem = OrbitItem(
      id: 'orbit-secondary-$projectId',
      itemType: OrbitItemType.project,
      itemId: projectId,
      role: OrbitRole.secondaryFocus,
      focusDate: focusDay.date,
      reason: 'Bewusst aktivierter Nebenfokus im Orbit.',
      activatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    final currentProjectSecondaryIds = focusDay.secondaryOrbitItemIds
        .where((id) => orbitItemById(id)?.itemType == OrbitItemType.project)
        .toList();
    final remainingProjectIds = currentProjectSecondaryIds.length >= 2
        ? currentProjectSecondaryIds.skip(1).toList()
        : currentProjectSecondaryIds;

    orbitItems = [
      ...orbitItems.where((item) => !currentProjectSecondaryIds.contains(item.id)),
      ...remainingProjectIds.map(orbitItemById).whereType<OrbitItem>(),
      newOrbitItem,
    ];

    final nonProjectSecondaryIds = focusDay.secondaryOrbitItemIds
        .where((id) => orbitItemById(id)?.itemType != OrbitItemType.project)
        .toList();

    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: focusDay.workMode,
      energyLevel: focusDay.energyLevel,
      primaryOrbitItemId: focusDay.primaryOrbitItemId,
      secondaryOrbitItemIds: [...remainingProjectIds, newOrbitItem.id, ...nonProjectSecondaryIds],
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Future<void> setWorkMode(WorkMode mode) async {
    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: mode,
      energyLevel: focusDay.energyLevel,
      primaryOrbitItemId: focusDay.primaryOrbitItemId,
      secondaryOrbitItemIds: focusDay.secondaryOrbitItemIds,
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Future<void> setEnergyLevel(EnergyLevel level) async {
    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: focusDay.workMode,
      energyLevel: level,
      primaryOrbitItemId: focusDay.primaryOrbitItemId,
      secondaryOrbitItemIds: focusDay.secondaryOrbitItemIds,
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
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
    await _commit();
  }

  Future<void> setMovementActivity(MovementActivityType activityType) async {
    movementPlan = MovementPlan(
      id: movementPlan.id,
      date: movementPlan.date,
      energyLevel: movementPlan.energyLevel,
      venue: movementPlan.venue,
      activityType: activityType,
      plannedStart: movementPlan.plannedStart,
      plannedDurationMinutes: movementPlan.plannedDurationMinutes,
      status: movementPlan.status,
      bookingSource: movementPlan.bookingSource,
      notes: movementPlan.notes,
      createdAt: movementPlan.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Future<void> setMovementStatus(MovementStatus status) async {
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
    await _commit();
  }

  Future<void> toggleRoutineDone(String routineId) async {
    if (completedRoutineIds.contains(routineId)) {
      completedRoutineIds.remove(routineId);
    } else {
      completedRoutineIds.add(routineId);
    }
    await _commit();
  }

  Future<void> toggleRhythmTaskDone(String taskId) async {
    if (completedRhythmTaskIds.contains(taskId)) {
      completedRhythmTaskIds.remove(taskId);
    } else {
      completedRhythmTaskIds.add(taskId);
    }
    await _commit();
  }

  Future<void> toggleTaskDone(String taskId) async {
    tasks = tasks
        .map(
          (task) => task.id == taskId
              ? task.copyWith(
                  status: task.status == TaskStatus.done
                      ? TaskStatus.next
                      : TaskStatus.done,
                  updatedAt: DateTime.now(),
                )
              : task,
        )
        .toList();
    await _commit();
  }

  Future<void> addIdea({
    required String rayId,
    required String title,
    required String summary,
    required MonetizationPotential monetizationPotential,
  }) async {
    final now = DateTime.now();
    ideas = [
      Idea(
        id: 'idea-${now.microsecondsSinceEpoch}',
        rayId: rayId,
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
            'Schaerfen und bewusst pruefen, ob es in ein Projekt uebergehen soll.',
        activationReadiness: ActivationReadiness.needsClarification,
        monetizationPotential: monetizationPotential,
        timeToFirstVersion: TimeToFirstVersion.oneWeek,
        proofOfOutput: ProofOfOutputType.none,
        tags: const [],
        createdByAi: false,
        aiNotes: '',
        createdAt: now,
        updatedAt: now,
      ),
      ...ideas,
    ];
    await _commit();
  }

  Future<void> convertIdeaToProject(String ideaId) async {
    final idea = ideaById(ideaId);
    if (idea == null) return;
    final now = DateTime.now();
    final projectId = 'project-${now.microsecondsSinceEpoch}';

    projects = [
      ...projects,
      Project(
        id: projectId,
        rayId: idea.rayId,
        slug: _slugify(idea.title),
        name: idea.title,
        description: idea.description,
        status: ProjectStatus.ready,
        priority: idea.priority,
        energyFit: rayById(idea.rayId).defaultEnergyFit,
        effortSize: 'medium',
        vision: idea.summary,
        currentGoal: idea.suggestedNextStep,
        monetizationPotential: idea.monetizationPotential,
        timeToFirstVersion: idea.timeToFirstVersion,
        proofOfOutput: idea.proofOfOutput,
        isEvergreen: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];

    ideas = ideas
        .map(
          (candidate) => candidate.id == idea.id
              ? candidate.copyWith(
                  status: IdeaStatus.done,
                  convertedToProjectId: projectId,
                  updatedAt: now,
                )
              : candidate,
        )
        .toList();

    tasks = [
      Task(
        id: 'task-$projectId',
        rayId: idea.rayId,
        projectId: projectId,
        title: 'Ersten validen Projektschritt definieren',
        description: idea.suggestedNextStep,
        status: TaskStatus.next,
        priority: idea.priority,
        energyFit: rayById(idea.rayId).defaultEnergyFit,
        estimatedMinutes: 45,
        isRoutine: false,
        scheduledForDate: focusDay.date,
        createdAt: now,
        updatedAt: now,
      ),
      ...tasks,
    ];
    await _commit();
  }

  Future<void> updateIdeaStatus(String ideaId, IdeaStatus status) async {
    ideas = ideas
        .map(
          (idea) => idea.id == ideaId
              ? idea.copyWith(status: status, updatedAt: DateTime.now())
              : idea,
        )
        .toList();
    await _commit();
  }

  Future<void> updateProjectStatus(String projectId, ProjectStatus status) async {
    projects = projects
        .map(
          (project) => project.id == projectId
              ? project.copyWith(status: status, updatedAt: DateTime.now())
              : project,
        )
        .toList();
    await _commit();
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    tasks = tasks
        .map(
          (task) => task.id == taskId
              ? task.copyWith(status: status, updatedAt: DateTime.now())
              : task,
        )
        .toList();
    await _commit();
  }

  Future<void> updateReview({
    required String dailyNote,
    required String distractionLog,
    required String dayReview,
  }) async {
    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: focusDay.workMode,
      energyLevel: focusDay.energyLevel,
      primaryOrbitItemId: focusDay.primaryOrbitItemId,
      secondaryOrbitItemIds: focusDay.secondaryOrbitItemIds,
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: dailyNote,
      distractionLog: distractionLog,
      dayReview: dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Future<void> setMustDoTasks(List<String> taskIds) async {
    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: focusDay.workMode,
      energyLevel: focusDay.energyLevel,
      primaryOrbitItemId: focusDay.primaryOrbitItemId,
      secondaryOrbitItemIds: focusDay.secondaryOrbitItemIds,
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: taskIds,
      optionalTaskIds: focusDay.optionalTaskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Future<void> setOptionalTasks(List<String> taskIds) async {
    focusDay = FocusDay(
      id: focusDay.id,
      date: focusDay.date,
      workMode: focusDay.workMode,
      energyLevel: focusDay.energyLevel,
      primaryOrbitItemId: focusDay.primaryOrbitItemId,
      secondaryOrbitItemIds: focusDay.secondaryOrbitItemIds,
      movementPlanId: focusDay.movementPlanId,
      mustDoTaskIds: focusDay.mustDoTaskIds,
      optionalTaskIds: taskIds,
      dailyNote: focusDay.dailyNote,
      distractionLog: focusDay.distractionLog,
      dayReview: focusDay.dayReview,
      createdAt: focusDay.createdAt,
      updatedAt: DateTime.now(),
    );
    await _commit();
  }

  Map<String, dynamic> toJson() => {
        'projects': projects.map((project) => project.toJson()).toList(),
        'ideas': ideas.map((idea) => idea.toJson()).toList(),
        'tasks': tasks.map((task) => task.toJson()).toList(),
        'orbitItems': orbitItems.map((item) => item.toJson()).toList(),
        'focusDay': focusDay.toJson(),
        'movementPlan': movementPlan.toJson(),
        'completedRoutineIds': completedRoutineIds.toList(),
        'completedRhythmTaskIds': completedRhythmTaskIds.toList(),
      };

  Future<void> resetToSeed() async {
    final fresh = SonnenkompassStore.seeded();
    projects = fresh.projects;
    ideas = fresh.ideas;
    tasks = fresh.tasks;
    orbitItems = fresh.orbitItems;
    focusDay = fresh.focusDay;
    movementPlan = fresh.movementPlan;
    completedRoutineIds = fresh.completedRoutineIds;
    completedRhythmTaskIds = fresh.completedRhythmTaskIds;
    await _commit();
  }

  Future<void> _commit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(toJson()));
    notifyListeners();
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

  String _slugify(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }
}
