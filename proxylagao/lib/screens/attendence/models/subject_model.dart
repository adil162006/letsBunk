class Subject {
  final String id;
  String name;
  int attendedLectures;
  int totalLectures;

  Subject({
    required this.id,
    required this.name,
    required this.attendedLectures,
    required this.totalLectures,
  });

  // Calculate attendance percentage
  double get attendancePercentage {
    if (totalLectures == 0) return 0.0;
    return (attendedLectures / totalLectures) * 100;
  }

  // Check if attendance meets minimum threshold
  bool meetsThreshold(double threshold) {
    return attendancePercentage >= threshold;
  }

  // Increment attended lectures (for present)
  void markPresent() {
    attendedLectures++;
    totalLectures++;
  }

  // Increment only total lectures (for absent)
  void markAbsent() {
    totalLectures++;
  }

  // Convert to JSON (for Supabase integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'attended_lectures': attendedLectures,
      'total_lectures': totalLectures,
    };
  }

  // Create from JSON (for Supabase integration)
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      attendedLectures: json['attended_lectures'] ?? 0,
      totalLectures: json['total_lectures'] ?? 0,
    );
  }

  // Create a copy of the subject
  Subject copyWith({
    String? id,
    String? name,
    int? attendedLectures,
    int? totalLectures,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      attendedLectures: attendedLectures ?? this.attendedLectures,
      totalLectures: totalLectures ?? this.totalLectures,
    );
  }

  @override
  String toString() {
    return 'Subject(id: $id, name: $name, attended: $attendedLectures, total: $totalLectures, percentage: ${attendancePercentage.toStringAsFixed(1)}%)';
  }
}