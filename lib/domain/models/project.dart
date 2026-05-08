import 'enums.dart';
import 'model_utils.dart';

class Project {
  const Project({
    required this.id,
    required this.rayId,
    required this.slug,
    required this.name,
    required this.description,
    required this.status,
    required this.priority,
    required this.energyFit,
    required this.effortSize,
    required this.vision,
    required this.currentGoal,
    required this.monetizationPotential,
    required this.timeToFirstVersion,
    required this.proofOfOutput,
    required this.isEvergreen,
    required this.createdAt,
    required this.updatedAt,
    this.nextReviewAt,
  });

  final String id;
  final String rayId;
  final String slug;
  final String name;
  final String description;
  final ProjectStatus status;
  final PriorityLevel priority;
  final EnergyLevel energyFit;
  final String effortSize;
  final String vision;
  final String currentGoal;
  final MonetizationPotential monetizationPotential;
  final TimeToFirstVersion timeToFirstVersion;
  final ProofOfOutputType proofOfOutput;
  final DateTime? nextReviewAt;
  final bool isEvergreen;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project copyWith({
    String? id,
    String? rayId,
    String? slug,
    String? name,
    String? description,
    ProjectStatus? status,
    PriorityLevel? priority,
    EnergyLevel? energyFit,
    String? effortSize,
    String? vision,
    String? currentGoal,
    MonetizationPotential? monetizationPotential,
    TimeToFirstVersion? timeToFirstVersion,
    ProofOfOutputType? proofOfOutput,
    DateTime? nextReviewAt,
    bool? isEvergreen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id ?? this.id,
      rayId: rayId ?? this.rayId,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      energyFit: energyFit ?? this.energyFit,
      effortSize: effortSize ?? this.effortSize,
      vision: vision ?? this.vision,
      currentGoal: currentGoal ?? this.currentGoal,
      monetizationPotential:
          monetizationPotential ?? this.monetizationPotential,
      timeToFirstVersion: timeToFirstVersion ?? this.timeToFirstVersion,
      proofOfOutput: proofOfOutput ?? this.proofOfOutput,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      isEvergreen: isEvergreen ?? this.isEvergreen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'rayId': rayId,
        'slug': slug,
        'name': name,
        'description': description,
        'status': enumToString(status),
        'priority': enumToString(priority),
        'energyFit': enumToString(energyFit),
        'effortSize': effortSize,
        'vision': vision,
        'currentGoal': currentGoal,
        'monetizationPotential': enumToString(monetizationPotential),
        'timeToFirstVersion': enumToString(timeToFirstVersion),
        'proofOfOutput': enumToString(proofOfOutput),
        'nextReviewAt': nextReviewAt?.toIso8601String(),
        'isEvergreen': isEvergreen,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      rayId: json['rayId'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      status: enumFromString(ProjectStatus.values, json['status'] as String),
      priority:
          enumFromString(PriorityLevel.values, json['priority'] as String),
      energyFit: enumFromString(EnergyLevel.values, json['energyFit'] as String),
      effortSize: json['effortSize'] as String,
      vision: json['vision'] as String,
      currentGoal: json['currentGoal'] as String,
      monetizationPotential: enumFromString(
        MonetizationPotential.values,
        json['monetizationPotential'] as String,
      ),
      timeToFirstVersion: enumFromString(
        TimeToFirstVersion.values,
        json['timeToFirstVersion'] as String,
      ),
      proofOfOutput: enumFromString(
        ProofOfOutputType.values,
        json['proofOfOutput'] as String,
      ),
      nextReviewAt: json['nextReviewAt'] == null
          ? null
          : DateTime.parse(json['nextReviewAt'] as String),
      isEvergreen: json['isEvergreen'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
