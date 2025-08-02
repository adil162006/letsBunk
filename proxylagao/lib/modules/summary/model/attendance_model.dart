class Attendance {
  final int attendedLectures;
  final int totalLectures;

  Attendance({required this.attendedLectures, required this.totalLectures});

  double get percentage =>
      totalLectures == 0 ? 0 : (attendedLectures / totalLectures) * 100;

  // Create a copy with updated values
  Attendance copyWith({
    int? attendedLectures,
    int? totalLectures,
  }) {
    return Attendance(
      attendedLectures: attendedLectures ?? this.attendedLectures,
      totalLectures: totalLectures ?? this.totalLectures,
    );
  }

  // Convert to JSON for Supabase storage
  Map<String, dynamic> toJson() {
    return {
      'attendedLectures': attendedLectures,
      'totalLectures': totalLectures,
    };
  }

  // Create from JSON
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendedLectures: json['attendedLectures'] ?? 0,
      totalLectures: json['totalLectures'] ?? 0,
    );
  }
} 