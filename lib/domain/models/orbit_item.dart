import 'enums.dart';
import 'model_utils.dart';

class OrbitItem {
  const OrbitItem({
    required this.id,
    required this.itemType,
    required this.itemId,
    required this.role,
    required this.focusDate,
    required this.reason,
    required this.activatedAt,
    required this.createdAt,
    this.expiresAt,
  });

  final String id;
  final OrbitItemType itemType;
  final String itemId;
  final OrbitRole role;
  final DateTime focusDate;
  final String reason;
  final DateTime activatedAt;
  final DateTime createdAt;
  final DateTime? expiresAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'itemType': enumToString(itemType),
        'itemId': itemId,
        'role': enumToString(role),
        'focusDate': focusDate.toIso8601String(),
        'reason': reason,
        'activatedAt': activatedAt.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'expiresAt': expiresAt?.toIso8601String(),
      };

  factory OrbitItem.fromJson(Map<String, dynamic> json) {
    return OrbitItem(
      id: json['id'] as String,
      itemType:
          enumFromString(OrbitItemType.values, json['itemType'] as String),
      itemId: json['itemId'] as String,
      role: enumFromString(OrbitRole.values, json['role'] as String),
      focusDate: DateTime.parse(json['focusDate'] as String),
      reason: json['reason'] as String,
      activatedAt: DateTime.parse(json['activatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );
  }
}
