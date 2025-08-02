import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../../../services/attendance_service.dart';
import '../../../services/supabase_service.dart';
import '../../../sample_data.dart';

class AttendanceController extends ChangeNotifier {
  // Private variables
  List<Subject> _subjects = [];
  double _minimumThreshold = 75.0;
  int _selectedNavIndex = 0;
  bool _isLoading = false;
  String? _userId;

  // Getters
  List<Subject> get subjects => _subjects;
  double get minimumThreshold => _minimumThreshold;
  int get selectedNavIndex => _selectedNavIndex;
  bool get isLoading => _isLoading;

  // Constructor - initialize with sample data
  AttendanceController() {
    _initialize();
  }

  // Initialize controller
  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get current user ID (or use default for demo)
      final user = SupabaseService.auth.currentUser;
      if (user != null) {
        _userId = user.id;
      } else {
        // Use a default user ID for demo purposes when login is disabled
        _userId = 'demo-user-123';
        debugPrint('Using demo user ID: $_userId');
      }
      
      // Load user settings
      try {
        _minimumThreshold = await AttendanceService.getAttendanceThreshold(_userId!);
      } catch (e) {
        debugPrint('Error loading attendance threshold: $e');
        _minimumThreshold = 75.0; // Default threshold
      }
      
      // Load subjects from Supabase
      try {
        await loadSubjects();
      } catch (e) {
        debugPrint('Error loading subjects: $e');
        _loadSampleData();
      }
    } catch (e) {
      debugPrint('Error initializing attendance controller: $e');
      _loadSampleData();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load subjects from Supabase
  Future<void> loadSubjects() async {
    if (_userId == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      _subjects = await AttendanceService.getSubjects(_userId!);
    } catch (e) {
      debugPrint('Error loading subjects: $e');
      _loadSampleData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load sample data (fallback)
  void _loadSampleData() {
    _subjects = List.from(SampleData.subjects);
    notifyListeners();
  }

  // Update minimum attendance threshold
  Future<void> updateThreshold(double newThreshold) async {
    _minimumThreshold = newThreshold;
    notifyListeners();

    if (_userId != null) {
      try {
        await AttendanceService.updateAttendanceThreshold(_userId!, newThreshold);
      } catch (e) {
        debugPrint('Error updating threshold: $e');
      }
    }
  }

  // Add new subject
  Future<void> addSubject(String name, int attendedLectures, int totalLectures) async {
    if (_userId == null) return;

    try {
      await AttendanceService.addSubject(_userId!, name, attendedLectures, totalLectures);
      
      // Reload subjects to get the updated list
      await loadSubjects();
    } catch (e) {
      debugPrint('Error adding subject: $e');
      rethrow;
    }
  }

  // Mark attendance as present
  Future<void> markPresent(String subjectId) async {
    if (_userId == null) return;

    try {
      await AttendanceService.markAttendance(_userId!, subjectId, 'present');
      
      // Update local state
      final subjectIndex = _subjects.indexWhere((s) => s.id == subjectId);
      if (subjectIndex != -1) {
        _subjects[subjectIndex].markPresent();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error marking present: $e');
      rethrow;
    }
  }

  // Mark attendance as absent
  Future<void> markAbsent(String subjectId) async {
    if (_userId == null) return;

    try {
      await AttendanceService.markAttendance(_userId!, subjectId, 'absent');
      
      // Update local state
      final subjectIndex = _subjects.indexWhere((s) => s.id == subjectId);
      if (subjectIndex != -1) {
        _subjects[subjectIndex].markAbsent();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error marking absent: $e');
      rethrow;
    }
  }

  // Update selected navigation index
  void updateNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  // Remove subject
  Future<void> removeSubject(String subjectId) async {
    try {
      await AttendanceService.deleteSubject(subjectId);
      
      // Update local state
      _subjects.removeWhere((s) => s.id == subjectId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error removing subject: $e');
      rethrow;
    }
  }

  // Update subject details
  Future<void> updateSubject(String subjectId, {
    String? name,
    int? attendedLectures,
    int? totalLectures,
  }) async {
    try {
      await AttendanceService.updateSubject(subjectId,
        name: name,
        attendedLectures: attendedLectures,
        totalLectures: totalLectures,
      );
      
      // Update local state
      final subjectIndex = _subjects.indexWhere((s) => s.id == subjectId);
      if (subjectIndex != -1) {
        final subject = _subjects[subjectIndex];
        _subjects[subjectIndex] = subject.copyWith(
          name: name,
          attendedLectures: attendedLectures,
          totalLectures: totalLectures,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating subject: $e');
      rethrow;
    }
  }

  // Get subject by ID
  Subject? getSubjectById(String id) {
    try {
      return _subjects.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get subjects with good attendance
  List<Subject> getSubjectsWithGoodAttendance() {
    return _subjects.where((s) => s.meetsThreshold(_minimumThreshold)).toList();
  }

  // Get subjects with poor attendance
  List<Subject> getSubjectsWithPoorAttendance() {
    return _subjects.where((s) => !s.meetsThreshold(_minimumThreshold)).toList();
  }

  // Calculate overall attendance percentage
  double get overallAttendancePercentage {
    if (_subjects.isEmpty) return 0.0;
    
    int totalAttended = _subjects.fold(0, (sum, s) => sum + s.attendedLectures);
    int totalLectures = _subjects.fold(0, (sum, s) => sum + s.totalLectures);
    
    if (totalLectures == 0) return 0.0;
    return (totalAttended / totalLectures) * 100;
  }

  // Refresh data
  Future<void> refresh() async {
    await loadSubjects();
  }
}