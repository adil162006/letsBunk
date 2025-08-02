class Attendance {
  final int attendedLectures;
  final int totalLectures;

  Attendance({required this.attendedLectures, required this.totalLectures});

  double get percentage =>
      totalLectures == 0 ? 0 : (attendedLectures / totalLectures) * 100;

  // Check if attendance meets minimum threshold
  bool meetsThreshold(double threshold) {
    return percentage >= threshold;
  }

  // Get attendance status text
  String getStatusText(double threshold) {
    if (percentage >= threshold) {
      return 'Good Attendance';
    } else if (percentage >= threshold - 10) {
      return 'Moderate Attendance';
    } else {
      return 'Poor Attendance';
    }
  }

  // Get status icon
  String getStatusIcon(double threshold) {
    if (percentage >= threshold) {
      return '✅';
    } else if (percentage >= threshold - 10) {
      return '⚠️';
    } else {
      return '❌';
    }
  }

  // Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'attended_lectures': attendedLectures,
      'total_lectures': totalLectures,
    };
  }

  // Create from JSON
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendedLectures: json['attended_lectures'] ?? 0,
      totalLectures: json['total_lectures'] ?? 0,
    );
  }

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

  @override
  String toString() {
    return 'Attendance(attended: $attendedLectures, total: $totalLectures, percentage: ${percentage.toStringAsFixed(2)}%)';
  }
} 