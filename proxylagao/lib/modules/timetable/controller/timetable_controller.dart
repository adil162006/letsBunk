import 'package:flutter/material.dart';
import '../model/timetable_day_model.dart';
import '../model/subject_model.dart';

class TimetableController extends ChangeNotifier {
  List<TimetableDay> _timetable = [];
  List<Subject> _subjects = [];
  bool _isLoading = false;

  // Getters
  List<TimetableDay> get timetable => _timetable;
  List<Subject> get subjects => _subjects;
  bool get isLoading => _isLoading;

  // Get today's subjects
  List<String> get todaySubjects {
    final today = DateTime.now().weekday;
    final dayNames = ['', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final todayName = dayNames[today];
    
    final todaySchedule = _timetable.firstWhere(
      (day) => day.day == todayName,
      orElse: () => TimetableDay(day: todayName, subjects: []),
    );
    
    return todaySchedule.subjects;
  }

  // Initialize with default timetable
  void initializeTimetable() {
    _isLoading = true;
    notifyListeners();

    // Create default timetable with empty subjects
    _timetable = [
      TimetableDay(day: 'Monday', subjects: []),
      TimetableDay(day: 'Tuesday', subjects: []),
      TimetableDay(day: 'Wednesday', subjects: []),
      TimetableDay(day: 'Thursday', subjects: []),
      TimetableDay(day: 'Friday', subjects: []),
      TimetableDay(day: 'Saturday', subjects: []),
      TimetableDay(day: 'Sunday', subjects: []),
    ];

    // Mock subjects for now
    _subjects = [
      Subject(name: 'Mathematics', attended: 15, total: 20),
      Subject(name: 'Physics', attended: 12, total: 18),
      Subject(name: 'Chemistry', attended: 14, total: 16),
      Subject(name: 'Biology', attended: 10, total: 15),
      Subject(name: 'English', attended: 18, total: 20),
    ];

    _isLoading = false;
    notifyListeners();
  }

  // Update subjects list (called from other screens)
  void updateSubjects(List<Subject> subjects) {
    _subjects = subjects;
    notifyListeners();
  }

  // Update timetable for a specific day
  void updateDayTimetable(String day, List<String> subjects) {
    final index = _timetable.indexWhere((d) => d.day == day);
    if (index != -1) {
      _timetable[index] = TimetableDay(day: day, subjects: subjects);
      notifyListeners();
    }
  }

  // Mark attendance for today's subjects
  Future<void> markTodayAttendance() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Update attendance for today's subjects
      for (String subjectName in todaySubjects) {
        final subjectIndex = _subjects.indexWhere((s) => s.name == subjectName);
        if (subjectIndex != -1) {
          final subject = _subjects[subjectIndex];
          _subjects[subjectIndex] = subject.copyWith(
            attended: subject.attended + 1,
            total: subject.total + 1,
          );
        }
      }

      _isLoading = false;
      notifyListeners();

      // TODO: Implement Supabase integration
      // await supabase.from('subjects').upsert(_subjects.map((s) => s.toJson()).toList());
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Get subject names for dropdowns
  List<String> get subjectNames => _subjects.map((s) => s.name).toList();

  // Save timetable to Supabase (mock implementation)
  Future<void> saveTimetable() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement Supabase integration
      // await supabase.from('timetable').upsert(_timetable.map((t) => t.toJson()).toList());

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Load timetable from Supabase (mock implementation)
  Future<void> loadTimetable() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement Supabase integration
      // final response = await supabase.from('timetable').select();
      // _timetable = response.map((json) => TimetableDay.fromJson(json)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
} 