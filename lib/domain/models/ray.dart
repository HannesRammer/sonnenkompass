import 'enums.dart';
import 'model_utils.dart';

class Ray {
  const Ray({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.type,
    required this.color,
    required this.icon,
    required this.sortOrder,
    required this.isActive,
    required this.defaultEnergyFit,
    required this.createdAt,
    required this.updatedAt,
    this.parentRayId,
  });

  final String id;
  final String slug;
  final String name;
  final String description;
  final RayType type;
  final String color;
  final String icon;
  final int sortOrder;
  final bool isActive;
  final EnergyLevel defaultEnergyFit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? parentRayId;

  Ray copyWith({
    String? id,
    String? slug,
    String? name,
    String? description,
    RayType? type,
    String? color,
    String? icon,
    int? sortOrder,
    bool? isActive,
    EnergyLevel? defaultEnergyFit,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? parentRayId,
  }) {
    return Ray(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      defaultEnergyFit: defaultEnergyFit ?? this.defaultEnergyFit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parentRayId: parentRayId ?? this.parentRayId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'name': name,
        'description': description,
        'type': enumToString(type),
        'color': color,
        'icon': icon,
        'sortOrder': sortOrder,
        'isActive': isActive,
        'defaultEnergyFit': enumToString(defaultEnergyFit),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'parentRayId': parentRayId,
      };

  factory Ray.fromJson(Map<String, dynamic> json) {
    return Ray(
      id: json['id'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: enumFromString(RayType.values, json['type'] as String),
      color: json['color'] as String,
      icon: json['icon'] as String,
      sortOrder: json['sortOrder'] as int,
      isActive: json['isActive'] as bool,
      defaultEnergyFit: enumFromString(
          EnergyLevel.values, json['defaultEnergyFit'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      parentRayId: json['parentRayId'] as String?,
    );
  }
}
