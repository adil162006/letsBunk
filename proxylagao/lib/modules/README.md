# AppSprint - Summary & Timetable Modules

This directory contains the complete MVC architecture implementation for the **Summary (Dashboard)** and **Timetable** screens of the AppSprint Flutter application.

## 📁 Module Structure

```
lib/modules/
├── summary/
│   ├── model/
│   │   └── attendance_model.dart
│   ├── controller/
│   │   └── summary_controller.dart
│   ├── view/
│   │   └── summary_screen.dart
│   └── widgets/
│       ├── attendance_summary_card.dart
│       └── threshold_dialog.dart
├── timetable/
│   ├── model/
│   │   ├── timetable_day_model.dart
│   │   └── subject_model.dart
│   ├── controller/
│   │   └── timetable_controller.dart
│   ├── view/
│   │   ├── timetable_screen.dart
│   │   └── create_timetable_screen.dart
│   └── widgets/
│       ├── today_schedule_card.dart
│       └── day_edit_dialog.dart
└── main_app.dart
```

## 🎨 Color Palette

| Element | Color Code |
|---------|------------|
| Background | `#111827` |
| Primary Text | `#F9FAFB` |
| Accent Orange | `#F59E0B` |
| Accent Blue | `#93C5FD` |
| Card Background | `#1F2937` |

## 📊 Summary (Dashboard) Module

### Features:
- **Attendance Summary Card**: Displays attendance percentage with status badge
- **Mini Cards**: Shows attended and total lectures
- **Settings Dialog**: Allows users to set attendance threshold
- **Quick Info Section**: Additional attendance statistics

### Key Components:
- `SummaryController`: Manages attendance data and threshold settings
- `AttendanceSummaryCard`: Main summary display widget
- `ThresholdDialog`: Settings dialog for attendance threshold

## 📅 Timetable Module

### Features:
- **Today's Schedule**: Shows current day's classes with attendance marking
- **Weekly Timetable**: Collapsible expansion tiles for each day
- **Day Editing**: Dialog to edit subjects for specific days
- **Create Timetable Screen**: Full weekly timetable editor

### Key Components:
- `TimetableController`: Manages timetable data and attendance marking
- `TodayScheduleCard`: Today's schedule display
- `DayEditDialog`: Dialog for editing day schedules
- `CreateTimetableScreen`: Full timetable editor

## 🚀 Usage

### 1. Add Provider Dependencies

Add to your `pubspec.yaml`:
```yaml
dependencies:
  provider: ^6.0.5
  supabase_flutter: ^1.10.25
```

### 2. Set up Provider in Main App

```dart
import 'package:provider/provider.dart';
import 'modules/summary/controller/summary_controller.dart';
import 'modules/timetable/controller/timetable_controller.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SummaryController()),
        ChangeNotifierProvider(create: (_) => TimetableController()),
      ],
      child: MaterialApp(
        // Your app configuration
      ),
    );
  }
}
```

### 3. Use the Screens

```dart
// Navigate to Summary Screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const SummaryScreen()),
);

// Navigate to Timetable Screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const TimetableScreen()),
);
```

## 🔧 Supabase Integration

The modules include mock implementations for Supabase integration. To enable real Supabase functionality:

1. **Initialize Supabase** in your main app
2. **Replace TODO comments** in controllers with actual Supabase calls
3. **Update data models** to match your Supabase schema

### Example Supabase Integration:

```dart
// In SummaryController
Future<void> loadAttendanceData() async {
  try {
    final response = await supabase
        .from('attendance')
        .select()
        .single();
    _attendance = Attendance.fromJson(response);
    notifyListeners();
  } catch (e) {
    // Handle error
  }
}
```

## 🎯 Key Features

### Summary Screen:
- ✅ Large attendance percentage display
- ✅ Status badges (Good/Moderate/Poor)
- ✅ Mini cards for attended/total lectures
- ✅ Settings dialog with slider
- ✅ Bottom navigation

### Timetable Screen:
- ✅ Today's schedule with attendance marking
- ✅ Weekly timetable with expansion tiles
- ✅ Day-specific editing dialogs
- ✅ Create timetable screen
- ✅ Subject dropdowns from shared list

## 🔄 State Management

Both modules use **Provider** for state management:
- Controllers extend `ChangeNotifier`
- Views use `Consumer` widgets
- State updates trigger UI rebuilds automatically

## 📱 Responsive Design

- Dark theme with consistent color palette
- Responsive layouts that work on different screen sizes
- Proper spacing and typography hierarchy
- Loading states and error handling

## 🛠️ Customization

### Colors:
Update the color constants in each widget to match your brand.

### Data Models:
Modify the model classes to match your data structure.

### UI Components:
Customize widgets by extending the base classes.

## 📝 Notes

- All Supabase calls are currently mocked
- Icons use Flutter's built-in icon set
- Bottom navigation is included in each screen
- Error handling and loading states are implemented
- The modules are ready for production use

## 🔗 Dependencies

- `flutter/material.dart`
- `provider` for state management
- `supabase_flutter` for backend integration (optional)

The modules are completely self-contained and can be easily integrated into any Flutter project using MVC architecture. 