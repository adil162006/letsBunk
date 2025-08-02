import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../theme.dart';
import '../main_navigation_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        if (authService.isLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
          );
        }

        // DISABLED LOGIN - Go directly to main app
        debugPrint('Login disabled - going directly to main app');
        return const MainNavigationPage();
        
        // Original authentication logic (commented out)
        /*
        // Check if user has a valid session and is authenticated (no email confirmation required)
        if (authService.isAuthenticatedWithSession) {
          debugPrint('User is authenticated with valid session: ${authService.getUserEmail()}');
          return const MainNavigationPage();
        } 
        // User is not authenticated, show login
        else {
          debugPrint('User not authenticated, showing login screen');
          return const LoginScreen();
        }
        */
      },
    );
  }
} 