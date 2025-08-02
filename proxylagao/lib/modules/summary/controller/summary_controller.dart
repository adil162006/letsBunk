import 'package:flutter/material.dart';
import '../model/attendance_model.dart';

class SummaryController extends ChangeNotifier {
  Attendance _attendance = Attendance(attendedLectures: 20, totalLectures: 28);
  double _attendanceThreshold = 75.0;
  bool _isLoading = false;

  // Getters
  Attendance get attendance => _attendance;
  double get attendanceThreshold => _attendanceThreshold;
  bool get isLoading => _isLoading;

  // Get attendance status
  String get attendanceStatus {
    if (_attendance.percentage >= _attendanceThreshold) {
      return 'Good Attendance';
    } else if (_attendance.percentage >= 60) {
      return 'Moderate Attendance';
    } else {
      return 'Poor Attendance';
    }
  }

  // Get status color
  Color get statusColor {
    if (_attendance.percentage >= _attendanceThreshold) {
      return Colors.green;
    } else if (_attendance.percentage >= 60) {
      return const Color(0xFFF59E0B); // Orange
    } else {
      return Colors.red;
    }
  }

  // Get status icon
  IconData get statusIcon {
    if (_attendance.percentage >= _attendanceThreshold) {
      return Icons.check_circle;
    } else if (_attendance.percentage >= 60) {
      return Icons.warning;
    } else {
      return Icons.error;
    }
  }

  // Update attendance threshold
  void updateThreshold(double threshold) {
    _attendanceThreshold = threshold;
    notifyListeners();
    
    // TODO: Save to Supabase
    // await supabase.from('settings').upsert({'attendance_threshold': threshold});
  }

  // Update attendance data
  void updateAttendance(Attendance attendance) {
    _attendance = attendance;
    notifyListeners();
  }

  // Load attendance data from Supabase (mock implementation)
  Future<void> loadAttendanceData() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement Supabase integration
      // final response = await supabase.from('attendance').select().single();
      // _attendance = Attendance.fromJson(response);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Load threshold from Supabase (mock implementation)
  Future<void> loadThreshold() async {
    try {
      // TODO: Implement Supabase integration
      // final response = await supabase.from('settings').select().single();
      // _attendanceThreshold = response['attendance_threshold'] ?? 75.0;
      
      notifyListeners();
    } catch (e) {
      // Use default threshold if loading fails
      _attendanceThreshold = 75.0;
      notifyListeners();
    }
  }

  // Save attendance data to Supabase (mock implementation)
  Future<void> saveAttendanceData() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement Supabase integration
      // await supabase.from('attendance').upsert(_attendance.toJson());

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
} 