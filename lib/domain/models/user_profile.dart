class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.timezone,
    required this.locale,
    required this.homeBase,
    required this.workBase,
    required this.workStartAnchor,
    required this.protectedWorkWindowStart,
    required this.protectedWorkWindowEnd,
    required this.urbanSportsEnabled,
    required this.defaultMovementVenue,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  final String id;
  final String displayName;
  final String timezone;
  final String locale;
  final String homeBase;
  final String workBase;
  final String workStartAnchor;
  final String protectedWorkWindowStart;
  final String protectedWorkWindowEnd;
  final bool urbanSportsEnabled;
  final String defaultMovementVenue;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'timezone': timezone,
        'locale': locale,
        'homeBase': homeBase,
        'workBase': workBase,
        'workStartAnchor': workStartAnchor,
        'protectedWorkWindowStart': protectedWorkWindowStart,
        'protectedWorkWindowEnd': protectedWorkWindowEnd,
        'urbanSportsEnabled': urbanSportsEnabled,
        'defaultMovementVenue': defaultMovementVenue,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      timezone: json['timezone'] as String,
      locale: json['locale'] as String,
      homeBase: json['homeBase'] as String,
      workBase: json['workBase'] as String,
      workStartAnchor: json['workStartAnchor'] as String,
      protectedWorkWindowStart: json['protectedWorkWindowStart'] as String,
      protectedWorkWindowEnd: json['protectedWorkWindowEnd'] as String,
      urbanSportsEnabled: json['urbanSportsEnabled'] as bool,
      defaultMovementVenue: json['defaultMovementVenue'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
