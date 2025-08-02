import 'package:flutter/material.dart';
import '../models/attendance_model.dart';

class SummaryController extends ChangeNotifier {
  // Private variables
  Attendance _attendance = Attendance(attendedLectures: 20, totalLectures: 28);
  double _attendanceThreshold = 75.0;
  int _selectedNavIndex = 1; // Dashboard is selected
  bool _isLoading = false;

  // Getters
  Attendance get attendance => _attendance;
  double get attendanceThreshold => _attendanceThreshold;
  int get selectedNavIndex => _selectedNavIndex;
  bool get isLoading => _isLoading;

  // Constructor
  SummaryController() {
    _loadAttendanceData();
  }

  // Load attendance data (simulate API call)
  Future<void> _loadAttendanceData() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data - in real app, this would come from Supabase
    _attendance = Attendance(attendedLectures: 20, totalLectures: 28);
    
    _isLoading = false;
    notifyListeners();
  }

  // Update attendance threshold
  void updateThreshold(double newThreshold) {
    _attendanceThreshold = newThreshold;
    notifyListeners();
    
    // TODO: In future, sync with Supabase
    // await _supabaseService.updateThreshold(newThreshold);
  }

  // Update selected navigation index
  void updateNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  // Refresh attendance data
  Future<void> refreshData() async {
    await _loadAttendanceData();
  }

  // Get attendance status
  String getAttendanceStatus() {
    return _attendance.getStatusText(_attendanceThreshold);
  }

  // Get attendance status icon
  String getAttendanceStatusIcon() {
    return _attendance.getStatusIcon(_attendanceThreshold);
  }

  // Check if attendance meets threshold
  bool get isAttendanceGood => _attendance.meetsThreshold(_attendanceThreshold);

  // Get attendance percentage
  double get attendancePercentage => _attendance.percentage;

  // Get attended lectures count
  int get attendedLectures => _attendance.attendedLectures;

  // Get total lectures count
  int get totalLectures => _attendance.totalLectures;

  // Get missed lectures count
  int get missedLectures => _attendance.totalLectures - _attendance.attendedLectures;

  // Get progress color based on attendance
  Color getProgressColor() {
    if (_attendance.meetsThreshold(_attendanceThreshold)) {
      return const Color(0xFF10B981); // Green
    } else if (_attendance.percentage >= _attendanceThreshold - 10) {
      return const Color(0xFFF59E0B); // Orange
    } else {
      return const Color(0xFFEF4444); // Red
    }
  }

  // Get status color
  Color getStatusColor() {
    if (_attendance.meetsThreshold(_attendanceThreshold)) {
      return const Color(0xFF10B981); // Green
    } else if (_attendance.percentage >= _attendanceThreshold - 10) {
      return const Color(0xFFF59E0B); // Orange
    } else {
      return const Color(0xFFEF4444); // Red
    }
  }

  // Controller cleanup handled automatically by ChangeNotifier
} 