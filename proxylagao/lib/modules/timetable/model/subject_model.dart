class Subject {
  final String name;
  final int attended;
  final int total;

  Subject({
    required this.name,
    required this.attended,
    required this.total,
  });

  double get percentage => total == 0 ? 0 : (attended / total) * 100;

  // Create a copy with updated values
  Subject copyWith({
    String? name,
    int? attended,
    int? total,
  }) {
    return Subject(
      name: name ?? this.name,
      attended: attended ?? this.attended,
      total: total ?? this.total,
    );
  }

  // Convert to JSON for Supabase storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'attended': attended,
      'total': total,
    };
  }

  // Create from JSON
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'] ?? '',
      attended: json['attended'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
} 