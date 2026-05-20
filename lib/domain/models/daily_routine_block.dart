import 'enums.dart';
import 'model_utils.dart';

class DailyRoutineBlock {
  const DailyRoutineBlock({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.defaultDurationMinutes,
    required this.flexibility,
    required this.isDaily,
    required this.isActive,
    this.defaultStartTime,
    this.notes,
  });

  final String id;
  final String userId;
  final String name;
  final RoutineCategory category;
  final String? defaultStartTime;
  final int defaultDurationMinutes;
  final Flexibility flexibility;
  final bool isDaily;
  final bool isActive;
  final String? notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'category': enumToString(category),
        'defaultStartTime': defaultStartTime,
        'defaultDurationMinutes': defaultDurationMinutes,
        'flexibility': enumToString(flexibility),
        'isDaily': isDaily,
        'isActive': isActive,
        'notes': notes,
      };

  factory DailyRoutineBlock.fromJson(Map<String, dynamic> json) {
    return DailyRoutineBlock(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      category:
          enumFromString(RoutineCategory.values, json['category'] as String),
      defaultStartTime: json['defaultStartTime'] as String?,
      defaultDurationMinutes: json['defaultDurationMinutes'] as int,
      flexibility:
          enumFromString(Flexibility.values, json['flexibility'] as String),
      isDaily: json['isDaily'] as bool,
      isActive: json['isActive'] as bool,
      notes: json['notes'] as String?,
    );
  }
}
