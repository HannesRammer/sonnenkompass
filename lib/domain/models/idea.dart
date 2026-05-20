import 'enums.dart';
import 'model_utils.dart';

class Idea {
  const Idea({
    required this.id,
    required this.rayId,
    required this.title,
    required this.summary,
    required this.description,
    required this.status,
    required this.priority,
    required this.confidence,
    required this.sourceType,
    required this.sourceText,
    required this.capturedAt,
    required this.suggestedNextStep,
    required this.activationReadiness,
    required this.monetizationPotential,
    required this.timeToFirstVersion,
    required this.proofOfOutput,
    required this.tags,
    required this.createdByAi,
    required this.aiNotes,
    required this.createdAt,
    required this.updatedAt,
    this.projectId,
    this.duplicateOfIdeaId,
    this.convertedToProjectId,
    this.archivedReason,
  });

  final String id;
  final String rayId;
  final String? projectId;
  final String title;
  final String summary;
  final String description;
  final IdeaStatus status;
  final PriorityLevel priority;
  final double confidence;
  final IdeaSourceType sourceType;
  final String sourceText;
  final DateTime capturedAt;
  final String suggestedNextStep;
  final ActivationReadiness activationReadiness;
  final MonetizationPotential monetizationPotential;
  final TimeToFirstVersion timeToFirstVersion;
  final ProofOfOutputType proofOfOutput;
  final List<String> tags;
  final bool createdByAi;
  final String aiNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? duplicateOfIdeaId;
  final String? convertedToProjectId;
  final String? archivedReason;

  Idea copyWith({
    String? id,
    String? rayId,
    String? projectId,
    String? title,
    String? summary,
    String? description,
    IdeaStatus? status,
    PriorityLevel? priority,
    double? confidence,
    IdeaSourceType? sourceType,
    String? sourceText,
    DateTime? capturedAt,
    String? suggestedNextStep,
    ActivationReadiness? activationReadiness,
    MonetizationPotential? monetizationPotential,
    TimeToFirstVersion? timeToFirstVersion,
    ProofOfOutputType? proofOfOutput,
    List<String>? tags,
    bool? createdByAi,
    String? aiNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? duplicateOfIdeaId,
    String? convertedToProjectId,
    String? archivedReason,
  }) {
    return Idea(
      id: id ?? this.id,
      rayId: rayId ?? this.rayId,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      confidence: confidence ?? this.confidence,
      sourceType: sourceType ?? this.sourceType,
      sourceText: sourceText ?? this.sourceText,
      capturedAt: capturedAt ?? this.capturedAt,
      suggestedNextStep: suggestedNextStep ?? this.suggestedNextStep,
      activationReadiness: activationReadiness ?? this.activationReadiness,
      monetizationPotential:
          monetizationPotential ?? this.monetizationPotential,
      timeToFirstVersion: timeToFirstVersion ?? this.timeToFirstVersion,
      proofOfOutput: proofOfOutput ?? this.proofOfOutput,
      tags: tags ?? this.tags,
      createdByAi: createdByAi ?? this.createdByAi,
      aiNotes: aiNotes ?? this.aiNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      duplicateOfIdeaId: duplicateOfIdeaId ?? this.duplicateOfIdeaId,
      convertedToProjectId: convertedToProjectId ?? this.convertedToProjectId,
      archivedReason: archivedReason ?? this.archivedReason,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'rayId': rayId,
        'projectId': projectId,
        'title': title,
        'summary': summary,
        'description': description,
        'status': enumToString(status),
        'priority': enumToString(priority),
        'confidence': confidence,
        'sourceType': enumToString(sourceType),
        'sourceText': sourceText,
        'capturedAt': capturedAt.toIso8601String(),
        'suggestedNextStep': suggestedNextStep,
        'activationReadiness': enumToString(activationReadiness),
        'monetizationPotential': enumToString(monetizationPotential),
        'timeToFirstVersion': enumToString(timeToFirstVersion),
        'proofOfOutput': enumToString(proofOfOutput),
        'tags': tags,
        'createdByAi': createdByAi,
        'aiNotes': aiNotes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'duplicateOfIdeaId': duplicateOfIdeaId,
        'convertedToProjectId': convertedToProjectId,
        'archivedReason': archivedReason,
      };

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      id: json['id'] as String,
      rayId: json['rayId'] as String,
      projectId: json['projectId'] as String?,
      title: json['title'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      status: enumFromString(IdeaStatus.values, json['status'] as String),
      priority:
          enumFromString(PriorityLevel.values, json['priority'] as String),
      confidence: (json['confidence'] as num).toDouble(),
      sourceType:
          enumFromString(IdeaSourceType.values, json['sourceType'] as String),
      sourceText: json['sourceText'] as String,
      capturedAt: DateTime.parse(json['capturedAt'] as String),
      suggestedNextStep: json['suggestedNextStep'] as String,
      activationReadiness: enumFromString(
        ActivationReadiness.values,
        json['activationReadiness'] as String,
      ),
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
      tags: (json['tags'] as List<dynamic>).cast<String>(),
      createdByAi: json['createdByAi'] as bool,
      aiNotes: json['aiNotes'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      duplicateOfIdeaId: json['duplicateOfIdeaId'] as String?,
      convertedToProjectId: json['convertedToProjectId'] as String?,
      archivedReason: json['archivedReason'] as String?,
    );
  }
}
