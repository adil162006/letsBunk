# AppSprint - Flutter Attendance Management App

A modern Flutter application built with **MVC architecture** and **Supabase** backend for managing student attendance and timetables.

## 🚀 Features

### 📊 Dashboard (Summary) Screen
- **Visual Attendance Overview**: Large, prominent attendance percentage display
- **Smart Status Indicators**: Color-coded badges showing attendance status (Good/Moderate)
- **Configurable Threshold**: Settings dialog to set attendance threshold (default: 75%)
- **Quick Stats**: Mini cards showing attended vs total lectures
- **Modern UI**: Dark theme with orange accent colors

### 📅 Timetable Management
- **Weekly Schedule**: Expandable day-wise timetable view
- **Today's Schedule**: Dynamic display of current day's subjects
- **One-Click Attendance**: Mark attendance for all today's subjects
- **Flexible Configuration**: Edit number of lectures per day
- **Subject Management**: Dropdown selection from available subjects

## 🏗️ Architecture

### MVC Pattern
- **Model**: Data classes with `copyWith`, `toJson`, `fromJson` methods
- **View**: UI screens and widgets
- **Controller**: Business logic and state management using Provider

### State Management
- **Provider**: `ChangeNotifier` for reactive UI updates
- **Controllers**: `SummaryController` and `TimetableController`
- **Consumer Widgets**: Automatic UI updates on state changes

## 📁 Project Structure

```
lib/
├── modules/
│   ├── summary/
│   │   ├── model/
│   │   │   └── attendance_model.dart
│   │   ├── controller/
│   │   │   └── summary_controller.dart
│   │   ├── view/
│   │   │   └── summary_screen.dart
│   │   └── widgets/
│   │       ├── attendance_summary_card.dart
│   │       └── threshold_dialog.dart
│   └── timetable/
│       ├── model/
│       │   ├── timetable_day_model.dart
│       │   └── subject_model.dart
│       ├── controller/
│       │   └── timetable_controller.dart
│       ├── view/
│       │   ├── timetable_screen.dart
│       │   └── create_timetable_screen.dart
│       └── widgets/
│           ├── today_schedule_card.dart
│           └── day_edit_dialog.dart
├── main.dart
└── theme.dart
```

## 🎨 Design System

### Color Palette
- **Background**: `#111827` (Dark gray)
- **Primary Text**: `#F9FAFB` (Light gray)
- **Accent Orange**: `#F59E0B` (Attendance percentage)
- **Accent Blue**: `#93C5FD` (Interactive elements)
- **Card Background**: `#1F2937` (Medium gray)

### UI Components
- **Cards**: Rounded containers with subtle shadows
- **Badges**: Color-coded status indicators
- **Buttons**: Elevated buttons with hover effects
- **Dialogs**: Modal dialogs for settings and editing

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd letsBunk
   ```

2. **Install dependencies**
   ```bash
   cd proxylagao
   flutter pub get
   ```

3. **Configure Supabase** (Optional for now - using mock data)
   ```bash
   # Add your Supabase credentials to .env file
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Usage

### Dashboard Screen
1. **View Attendance**: See your overall attendance percentage
2. **Check Status**: Look at the colored badge for attendance status
3. **Configure Threshold**: Tap settings icon to adjust attendance threshold
4. **Quick Stats**: Review attended vs total lectures

### Timetable Screen
1. **View Schedule**: Expand days to see your weekly timetable
2. **Today's Subjects**: Check what's scheduled for today
3. **Mark Attendance**: Use "Mark Attendance" button for today's subjects
4. **Edit Timetable**: Tap edit icon to modify weekly schedule
5. **Configure Lectures**: Set number of lectures per day

## 🔧 Configuration

### Provider Setup
The app uses `MultiProvider` for state management:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => SummaryController()),
    ChangeNotifierProvider(create: (_) => TimetableController()),
  ],
  child: MaterialApp(...),
)
```

### Supabase Integration
Currently using mock data. To integrate with Supabase:

1. Add `supabase_flutter` dependency
2. Initialize Supabase in `main.dart`
3. Replace mock methods in controllers with actual API calls
4. Update models to handle Supabase data types

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📦 Dependencies

Key dependencies in `pubspec.yaml`:
- `flutter`: Core Flutter framework
- `provider`: State management
- `supabase_flutter`: Backend integration (when ready)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

For issues and questions:
- Create an issue in the repository
- Check the documentation
- Review the code comments for implementation details

---

**Built with ❤️ using Flutter and Supabase**

