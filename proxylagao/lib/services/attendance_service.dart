import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';
import '../screens/attendence/models/subject_model.dart';

class AttendanceService {
  static final SupabaseClient _supabase = SupabaseService.client;

  // Get all subjects for a user
  static Future<List<Subject>> getSubjects(String userId) async {
    try {
      final response = await _supabase
          .from('subjects')
          .select()
          .eq('user_id', userId)
          .order('name');
      
      return response.map<Subject>((json) => Subject.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching subjects: $e');
      return [];
    }
  }

  // Add new subject
  static Future<void> addSubject(String userId, String name, int attendedLectures, int totalLectures) async {
    try {
      await _supabase.from('subjects').insert({
        'user_id': userId,
        'name': name,
        'attended_lectures': attendedLectures,
        'total_lectures': totalLectures,
      });
    } catch (e) {
      debugPrint('Error adding subject: $e');
      rethrow;
    }
  }

  // Update subject
  static Future<void> updateSubject(String subjectId, {
    String? name,
    int? attendedLectures,
    int? totalLectures,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      if (name != null) updateData['name'] = name;
      if (attendedLectures != null) updateData['attended_lectures'] = attendedLectures;
      if (totalLectures != null) updateData['total_lectures'] = totalLectures;
      
      await _supabase
          .from('subjects')
          .update(updateData)
          .eq('id', subjectId);
    } catch (e) {
      debugPrint('Error updating subject: $e');
      rethrow;
    }
  }

  // Delete subject
  static Future<void> deleteSubject(String subjectId) async {
    try {
      await _supabase
          .from('subjects')
          .delete()
          .eq('id', subjectId);
    } catch (e) {
      debugPrint('Error deleting subject: $e');
      rethrow;
    }
  }

  // Mark attendance
  static Future<void> markAttendance(String userId, String subjectId, String status) async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      
      await _supabase.from('attendance_records').upsert({
        'user_id': userId,
        'subject_id': subjectId,
        'date': today,
        'status': status,
      });
    } catch (e) {
      debugPrint('Error marking attendance: $e');
      rethrow;
    }
  }

  // Get attendance summary
  static Future<Map<String, dynamic>> getAttendanceSummary(String userId) async {
    try {
      final response = await _supabase
          .from('subjects')
          .select('attended_lectures, total_lectures')
          .eq('user_id', userId);
      
      int totalAttended = 0;
      int totalLectures = 0;
      
      for (final row in response) {
        totalAttended += (row['attended_lectures'] ?? 0) as int;
        totalLectures += (row['total_lectures'] ?? 0) as int;
      }
      
      double percentage = totalLectures > 0 ? (totalAttended * 100.0 / totalLectures) : 0.0;
      
      return {
        'total_attended': totalAttended,
        'total_lectures': totalLectures,
        'percentage': percentage,
      };
    } catch (e) {
      debugPrint('Error getting attendance summary: $e');
      return {
        'total_attended': 0,
        'total_lectures': 0,
        'percentage': 0.0,
      };
    }
  }

  // Get user settings
  static Future<double> getAttendanceThreshold(String userId) async {
    try {
      final response = await _supabase
          .from('user_settings')
          .select('attendance_threshold')
          .eq('user_id', userId)
          .single();
      
      return (response['attendance_threshold'] ?? 75.0).toDouble();
    } catch (e) {
      debugPrint('Error getting attendance threshold: $e');
      return 75.0; // Default threshold
    }
  }

  // Update attendance threshold
  static Future<void> updateAttendanceThreshold(String userId, double threshold) async {
    try {
      await _supabase.from('user_settings').upsert({
        'user_id': userId,
        'attendance_threshold': threshold,
      });
    } catch (e) {
      debugPrint('Error updating attendance threshold: $e');
      rethrow;
    }
  }

  // Get today's attendance status
  static Future<List<Map<String, dynamic>>> getTodayAttendance(String userId) async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      
      final response = await _supabase
          .from('subjects')
          .select('''
            id,
            name,
            attendance_records!inner(status)
          ''')
          .eq('user_id', userId)
          .eq('attendance_records.date', today);
      
      return response.map((row) => {
        'subject_id': row['id'],
        'subject_name': row['name'],
        'status': row['attendance_records'][0]['status'],
      }).toList();
    } catch (e) {
      debugPrint('Error getting today\'s attendance: $e');
      return [];
    }
  }
} 