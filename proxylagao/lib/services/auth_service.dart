import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthService extends ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  bool _isEmailConfirmed = false;
  Session? _session;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null; // Removed email confirmation requirement
  bool get isEmailConfirmed => _isEmailConfirmed;
  Session? get session => _session;

  AuthService() {
    _initialize();
  }

  void _initialize() {
    try {
      // Get current session and user
      _session = SupabaseService.auth.currentSession;
      _user = _session?.user;
      _isEmailConfirmed = _user?.emailConfirmedAt != null;
      
      debugPrint('Auth initialization - User: ${_user?.email}, Session: ${_session != null}, EmailConfirmed: $_isEmailConfirmed');
      
      _isLoading = false;
      notifyListeners();

      // Listen to auth state changes
      SupabaseService.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final User? user = data.session?.user;
        final Session? session = data.session;

        debugPrint('Auth state changed: $event, User: ${user?.email}, Session: ${session != null}');

        if (event == AuthChangeEvent.signedIn && user != null) {
          _user = user;
          _session = session;
          _isEmailConfirmed = user.emailConfirmedAt != null;
          _isLoading = false;
          notifyListeners();
        } else if (event == AuthChangeEvent.signedOut) {
          _user = null;
          _session = null;
          _isEmailConfirmed = false;
          _isLoading = false;
          notifyListeners();
        } else if (event == AuthChangeEvent.userUpdated && user != null) {
          _user = user;
          _session = session;
          _isEmailConfirmed = user.emailConfirmedAt != null;
          _isLoading = false;
          notifyListeners();
        } else if (event == AuthChangeEvent.tokenRefreshed && session != null) {
          _session = session;
          _user = session.user;
          _isEmailConfirmed = session.user.emailConfirmedAt != null;
          _isLoading = false;
          notifyListeners();
        }
      });
    } catch (e) {
      debugPrint('Error initializing auth service: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  // Check if user has a valid session
  bool hasValidSession() {
    if (_session == null) return false;
    
    // For now, just check if session exists
    // Supabase handles session expiration automatically
    return _session!.accessToken.isNotEmpty;
  }

  // Get authentication status considering session persistence (no email confirmation required)
  bool get isAuthenticatedWithSession {
    return _user != null && hasValidSession();
  }

  Future<void> signOut() async {
    try {
      await SupabaseService.auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  String? getUserName() {
    return _user?.userMetadata?['name'] as String? ?? _user?.email;
  }

  String? getUserEmail() {
    return _user?.email;
  }

  // Check if user needs email confirmation (always false now)
  bool needsEmailConfirmation() {
    return false; // Skip email confirmation
  }

  // Resend email confirmation (kept for compatibility but not used)
  Future<void> resendEmailConfirmation() async {
    try {
      if (_user?.email != null) {
        await SupabaseService.auth.resend(
          type: OtpType.signup,
          email: _user!.email!,
        );
      }
    } catch (e) {
      debugPrint('Error resending email confirmation: $e');
      rethrow;
    }
  }

  // Refresh session if needed
  Future<void> refreshSession() async {
    try {
      if (_session != null) {
        await SupabaseService.auth.refreshSession();
      }
    } catch (e) {
      debugPrint('Error refreshing session: $e');
    }
  }
} 