class TimetableDay {
  final String day;
  final List<String> subjects; // list of subject names

  TimetableDay({required this.day, required this.subjects});

  // Create a copy with updated subjects
  TimetableDay copyWith({String? day, List<String>? subjects}) {
    return TimetableDay(
      day: day ?? this.day,
      subjects: subjects ?? this.subjects,
    );
  }

  // Convert to JSON for Supabase storage
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'subjects': subjects,
    };
  }

  // Create from JSON
  factory TimetableDay.fromJson(Map<String, dynamic> json) {
    return TimetableDay(
      day: json['day'] ?? '',
      subjects: List<String>.from(json['subjects'] ?? []),
    );
  }
} 