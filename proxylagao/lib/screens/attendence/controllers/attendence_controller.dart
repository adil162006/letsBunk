import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../../../sample_data.dart';

class AttendanceController extends ChangeNotifier {
  // Private variables
  List<Subject> _subjects = [];
  double _minimumThreshold = 75.0;
  int _selectedNavIndex = 0;

  // Getters
  List<Subject> get subjects => _subjects;
  double get minimumThreshold => _minimumThreshold;
  int get selectedNavIndex => _selectedNavIndex;

  // Constructor - initialize with sample data
  AttendanceController() {
    _loadSampleData();
  }

  // Load sample data (simulate database fetch)
  void _loadSampleData() {
    _subjects = List.from(SampleData.subjects);
    notifyListeners();
  }

  // Update minimum attendance threshold
  void updateThreshold(double newThreshold) {
    _minimumThreshold = newThreshold;
    notifyListeners();
  }

  // Add new subject
  void addSubject(String name, int attendedLectures, int totalLectures) {
    final newSubject = Subject(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      attendedLectures: attendedLectures,
      totalLectures: totalLectures,
    );
    
    _subjects.add(newSubject);
    notifyListeners();
    
    // TODO: In future, sync with Supabase
    // await _supabaseService.addSubject(newSubject);
  }

  // Mark attendance as present
  void markPresent(String subjectId) {
    final subjectIndex = _subjects.indexWhere((s) => s.id == subjectId);
    if (subjectIndex != -1) {
      _subjects[subjectIndex].markPresent();
      notifyListeners();
      
      // TODO: In future, sync with Supabase
      // await _supabaseService.updateSubject(_subjects[subjectIndex]);
    }
  }

  // Mark attendance as absent
  void markAbsent(String subjectId) {
    final subjectIndex = _subjects.indexWhere((s) => s.id == subjectId);
    if (subjectIndex != -1) {
      _subjects[subjectIndex].markAbsent();
      notifyListeners();
      
      // TODO: In future, sync with Supabase
      // await _supabaseService.updateSubject(_subjects[subjectIndex]);
    }
  }

  // Update selected navigation index
  void updateNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  // Remove subject
  void removeSubject(String subjectId) {
    _subjects.removeWhere((s) => s.id == subjectId);
    notifyListeners();
    
    // TODO: In future, sync with Supabase
    // await _supabaseService.deleteSubject(subjectId);
  }

  // Update subject details
  void updateSubject(String subjectId, {
    String? name,
    int? attendedLectures,
    int? totalLectures,
  }) {
    final subjectIndex = _subjects.indexWhere((s) => s.id == subjectId);
    if (subjectIndex != -1) {
      final subject = _subjects[subjectIndex];
      _subjects[subjectIndex] = subject.copyWith(
        name: name,
        attendedLectures: attendedLectures,
        totalLectures: totalLectures,
      );
      notifyListeners();
      
      // TODO: In future, sync with Supabase
      // await _supabaseService.updateSubject(_subjects[subjectIndex]);
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

  // Future methods for Supabase integration
  /*
  Future<void> syncWithSupabase() async {
    // Fetch subjects from Supabase
    final subjects = await _supabaseService.fetchSubjects();
    _subjects = subjects;
    notifyListeners();
  }

  Future<void> backupToSupabase() async {
    // Backup current subjects to Supabase
    for (final subject in _subjects) {
      await _supabaseService.upsertSubject(subject);
    }
  }
  */
}