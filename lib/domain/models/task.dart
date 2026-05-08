import 'enums.dart';
import 'model_utils.dart';

class Task {
  const Task({
    required this.id,
    required this.rayId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.energyFit,
    required this.estimatedMinutes,
    required this.isRoutine,
    required this.createdAt,
    required this.updatedAt,
    this.projectId,
    this.ideaId,
    this.scheduledForDate,
    this.dueAt,
  });

  final String id;
  final String rayId;
  final String? projectId;
  final String? ideaId;
  final String title;
  final String description;
  final TaskStatus status;
  final PriorityLevel priority;
  final EnergyLevel energyFit;
  final int estimatedMinutes;
  final DateTime? scheduledForDate;
  final DateTime? dueAt;
  final bool isRoutine;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'rayId': rayId,
        'projectId': projectId,
        'ideaId': ideaId,
        'title': title,
        'description': description,
        'status': enumToString(status),
        'priority': enumToString(priority),
        'energyFit': enumToString(energyFit),
        'estimatedMinutes': estimatedMinutes,
        'scheduledForDate': scheduledForDate?.toIso8601String(),
        'dueAt': dueAt?.toIso8601String(),
        'isRoutine': isRoutine,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      rayId: json['rayId'] as String,
      projectId: json['projectId'] as String?,
      ideaId: json['ideaId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      status: enumFromString(TaskStatus.values, json['status'] as String),
      priority:
          enumFromString(PriorityLevel.values, json['priority'] as String),
      energyFit: enumFromString(EnergyLevel.values, json['energyFit'] as String),
      estimatedMinutes: json['estimatedMinutes'] as int,
      scheduledForDate: json['scheduledForDate'] == null
          ? null
          : DateTime.parse(json['scheduledForDate'] as String),
      dueAt: json['dueAt'] == null
          ? null
          : DateTime.parse(json['dueAt'] as String),
      isRoutine: json['isRoutine'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

