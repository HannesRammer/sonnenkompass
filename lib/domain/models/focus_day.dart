import 'enums.dart';
import 'model_utils.dart';

class FocusDay {
  const FocusDay({
    required this.id,
    required this.date,
    required this.workMode,
    required this.energyLevel,
    required this.primaryOrbitItemId,
    required this.secondaryOrbitItemIds,
    required this.mustDoTaskIds,
    required this.optionalTaskIds,
    required this.createdAt,
    required this.updatedAt,
    this.movementPlanId,
    this.dailyNote,
    this.distractionLog,
    this.dayReview,
  });

  final String id;
  final DateTime date;
  final WorkMode workMode;
  final EnergyLevel energyLevel;
  final String primaryOrbitItemId;
  final List<String> secondaryOrbitItemIds;
  final String? movementPlanId;
  final List<String> mustDoTaskIds;
  final List<String> optionalTaskIds;
  final String? dailyNote;
  final String? distractionLog;
  final String? dayReview;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isWithinOrbitLimit => secondaryOrbitItemIds.length <= 2;

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'workMode': enumToString(workMode),
        'energyLevel': enumToString(energyLevel),
        'primaryOrbitItemId': primaryOrbitItemId,
        'secondaryOrbitItemIds': secondaryOrbitItemIds,
        'movementPlanId': movementPlanId,
        'mustDoTaskIds': mustDoTaskIds,
        'optionalTaskIds': optionalTaskIds,
        'dailyNote': dailyNote,
        'distractionLog': distractionLog,
        'dayReview': dayReview,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory FocusDay.fromJson(Map<String, dynamic> json) {
    return FocusDay(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      workMode: enumFromString(WorkMode.values, json['workMode'] as String),
      energyLevel:
          enumFromString(EnergyLevel.values, json['energyLevel'] as String),
      primaryOrbitItemId: json['primaryOrbitItemId'] as String,
      secondaryOrbitItemIds:
          (json['secondaryOrbitItemIds'] as List<dynamic>).cast<String>(),
      movementPlanId: json['movementPlanId'] as String?,
      mustDoTaskIds: (json['mustDoTaskIds'] as List<dynamic>).cast<String>(),
      optionalTaskIds:
          (json['optionalTaskIds'] as List<dynamic>).cast<String>(),
      dailyNote: json['dailyNote'] as String?,
      distractionLog: json['distractionLog'] as String?,
      dayReview: json['dayReview'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
