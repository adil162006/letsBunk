# Supabase Setup Guide

## Configuration

Your Supabase credentials are now configured directly in the code:

- **URL**: `https://kipantaarmykfxupujhr.supabase.co`
- **Anon Key**: Already configured in `lib/core/supabase_config.dart`

## Install dependencies

Run the following command to install the required packages:
```bash
flutter pub get
```

## Usage

You can now use Supabase in your app by importing the service:

```dart
import 'services/supabase_service.dart';

// Get the Supabase client
final supabase = SupabaseService.client;

// Get the auth instance
final auth = SupabaseService.auth;

// Example: Sign up a user
await auth.signUp(
  email: 'user@example.com',
  password: 'password123',
);
```

## Security Notes

- Keep your anon key secure and don't share it publicly
- For production apps, consider using environment variables for better security 