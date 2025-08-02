import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/summary/controller/summary_controller.dart';
import 'modules/timetable/controller/timetable_controller.dart';
import 'screens/attendence/controllers/attendence_controller.dart';
import 'services/supabase_service.dart';
import 'services/auth_service.dart';
import 'screens/auth/auth_wrapper.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Supabase
    await SupabaseService.initialize();
    
    // Test connection
    final connectionTest = await SupabaseService.testConnection();
    if (!connectionTest) {
      debugPrint('Warning: Supabase connection test failed');
    }
    
    runApp(const MyApp());
  } catch (e) {
    debugPrint('Error during app initialization: $e');
    // Still run the app even if Supabase fails
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SummaryController()),
        ChangeNotifierProvider(create: (_) => TimetableController()),
        ChangeNotifierProvider(create: (_) => AttendanceController()),
      ],
      child: MaterialApp(
        title: 'AppSprint',
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}