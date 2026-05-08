class RhythmTask {
  const RhythmTask({
    required this.id,
    required this.title,
    required this.category,
    required this.frequencyDays,
    required this.durationMinutes,
    required this.defaultWindow,
    required this.outsideHome,
    required this.notes,
  });

  final String id;
  final String title;
  final String category;
  final int frequencyDays;
  final int durationMinutes;
  final String defaultWindow;
  final bool outsideHome;
  final String notes;
}

