import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_config.dart';

class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();
  
  SupabaseService._();
  
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.supabaseUrl,
        anonKey: SupabaseConfig.supabaseAnonKey,
      );
      debugPrint('Supabase initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Supabase: $e');
      rethrow;
    }
  }
  
  static SupabaseClient get client => Supabase.instance.client;
  
  static GoTrueClient get auth => client.auth;
  
  // Test method to verify connection
  static Future<bool> testConnection() async {
    try {
      await client.from('subjects').select('count').limit(1);
      debugPrint('Supabase connection test successful');
      return true;
    } catch (e) {
      debugPrint('Supabase connection test failed: $e');
      return false;
    }
  }
} 