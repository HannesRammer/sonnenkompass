class FixedSlot {
  const FixedSlot({
    required this.id,
    required this.title,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.isFixed,
    this.notes,
  });

  final String id;
  final String title;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final String category;
  final bool isFixed;
  final String? notes;
}
