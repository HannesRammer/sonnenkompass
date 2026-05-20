import 'enums.dart';
import 'model_utils.dart';

class MovementPlan {
  const MovementPlan({
    required this.id,
    required this.date,
    required this.energyLevel,
    required this.venue,
    required this.activityType,
    required this.plannedDurationMinutes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.plannedStart,
    this.bookingSource,
    this.notes,
  });

  final String id;
  final DateTime date;
  final EnergyLevel energyLevel;
  final String venue;
  final MovementActivityType activityType;
  final DateTime? plannedStart;
  final int plannedDurationMinutes;
  final MovementStatus status;
  final String? bookingSource;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'energyLevel': enumToString(energyLevel),
        'venue': venue,
        'activityType': enumToString(activityType),
        'plannedStart': plannedStart?.toIso8601String(),
        'plannedDurationMinutes': plannedDurationMinutes,
        'status': enumToString(status),
        'bookingSource': bookingSource,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory MovementPlan.fromJson(Map<String, dynamic> json) {
    return MovementPlan(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      energyLevel:
          enumFromString(EnergyLevel.values, json['energyLevel'] as String),
      venue: json['venue'] as String,
      activityType: enumFromString(
        MovementActivityType.values,
        json['activityType'] as String,
      ),
      plannedStart: json['plannedStart'] == null
          ? null
          : DateTime.parse(json['plannedStart'] as String),
      plannedDurationMinutes: json['plannedDurationMinutes'] as int,
      status: enumFromString(MovementStatus.values, json['status'] as String),
      bookingSource: json['bookingSource'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
