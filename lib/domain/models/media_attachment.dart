import 'enums.dart';
import 'model_utils.dart';

class MediaAttachment {
  const MediaAttachment({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.type,
    required this.uri,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    required this.createdAt,
    this.previewText,
    this.transcript,
    this.analysisSummary,
  });

  final String id;
  final String ownerType;
  final String ownerId;
  final MediaType type;
  final String uri;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final String? previewText;
  final String? transcript;
  final String? analysisSummary;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerType': ownerType,
        'ownerId': ownerId,
        'type': enumToString(type),
        'uri': uri,
        'fileName': fileName,
        'mimeType': mimeType,
        'sizeBytes': sizeBytes,
        'previewText': previewText,
        'transcript': transcript,
        'analysisSummary': analysisSummary,
        'createdAt': createdAt.toIso8601String(),
      };

  factory MediaAttachment.fromJson(Map<String, dynamic> json) {
    return MediaAttachment(
      id: json['id'] as String,
      ownerType: json['ownerType'] as String,
      ownerId: json['ownerId'] as String,
      type: enumFromString(MediaType.values, json['type'] as String),
      uri: json['uri'] as String,
      fileName: json['fileName'] as String,
      mimeType: json['mimeType'] as String,
      sizeBytes: json['sizeBytes'] as int,
      previewText: json['previewText'] as String?,
      transcript: json['transcript'] as String?,
      analysisSummary: json['analysisSummary'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

