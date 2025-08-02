# AppSprint - Flutter Attendance Management App

A modern Flutter application built with **MVC architecture** and **Supabase** backend for managing student attendance and timetables.

## 🚀 Features

### 📊 Dashboard (Summary) Screen
- **Visual Attendance Overview**: Large, prominent attendance percentage display
- **Smart Status Indicators**: Color-coded badges showing attendance status (Good/Moderate/Poor)
- **Configurable Threshold**: Settings dialog to set attendance threshold (default: 75%)
- **Quick Stats**: Mini cards showing attended vs total lectures
- **Modern UI**: Dark theme with orange accent colors

### 📅 Timetable Management
- **Weekly Schedule**: Expandable day-wise timetable view
- **Today's Schedule**: Dynamic display of current day's subjects
- **One-Click Attendance**: Mark attendance for all today's subjects
- **Flexible Configuration**: Edit number of lectures per day
- **Subject Management**: Dropdown selection from available subjects

### 🔐 Authentication
- **User Registration**: Secure sign-up with email and password
- **User Login**: Authentication with Supabase
- **Session Management**: Automatic login state handling

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
├── core/
│   └── supabase_config.dart
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
├── screens/
│   ├── auth/
│   │   ├── auth_wrapper.dart
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── attendence/
│   │   ├── controllers/
│   │   ├── models/
│   │   └── views/
│   └── main_navigation_page.dart
├── services/
│   ├── auth_service.dart
│   └── supabase_service.dart
└── main.dart
```

## 🎨 Design System

### Color Palette
| Element | Color Code |
|---------|------------|
| Background | `#111827` |
| Primary Text | `#F9FAFB` |
| Accent Orange | `#F59E0B` |
| Accent Blue | `#93C5FD` |
| Card Background | `#1F2937` |

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (^3.8.1)
- Dart SDK
- Android Studio / VS Code
- Supabase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd proxylagao
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Update `lib/core/supabase_config.dart` with your Supabase credentials
   - Follow the setup guide in `SUPABASE_SETUP.md`

4. **Run the application**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Supabase Setup
1. Create a new Supabase project
2. Update the URL and anon key in `lib/core/supabase_config.dart`
3. Create the following tables in your Supabase database:
   - `users` - for user authentication
   - `attendance` - for attendance records
   - `timetable` - for timetable data
   - `subjects` - for subject information

### Environment Variables
For production, consider using environment variables for sensitive data:
```dart
// Example: Use environment variables
static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
```

## 📱 Usage

### Authentication
- Register with email and password
- Login with existing credentials
- Automatic session management

### Attendance Tracking
- View attendance summary on dashboard
- Set attendance threshold in settings
- Monitor attendance status with color-coded indicators

### Timetable Management
- Create weekly timetable
- Mark attendance for today's classes
- Edit subject schedules per day
- View today's schedule at a glance

## 🧪 Testing

Run tests using:
```bash
flutter test
```

## 📦 Dependencies

### Core Dependencies
- `flutter`: ^3.8.1
- `provider`: ^6.1.1 (State management)
- `supabase_flutter`: ^2.3.4 (Backend integration)
- `cupertino_icons`: ^1.0.8 (iOS icons)

### Development Dependencies
- `flutter_test`: SDK
- `flutter_lints`: ^5.0.0 (Code quality)

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues:
1. Check the [Issues](https://github.com/your-repo/issues) page
2. Create a new issue with detailed description
3. Include error logs and device information

## 🔄 Version History

- **v1.0.0**: Initial release with basic attendance tracking and timetable management
- **v1.0.1**: Added authentication system and Supabase integration
- **v1.0.2**: Enhanced UI with dark theme and improved user experience

## 📞 Contact

- **Developer**: [Your Name]
- **Email**: [your.email@example.com]
- **GitHub**: [@your-username]

---

**Made with ❤️ using Flutter and Supabase**
