# 📱 StayAddis Flutter Mobile App

A modern hotel booking mobile application built with **Flutter 3.44** and **Dart**. Browse hotels, view galleries, and make instant bookings with a responsive Material Design UI.

## 🎯 Features

- 🏨 Hotel listing with image galleries (73 photos)
- 🖼️ Beautiful hotel details and room showcase
- 📅 Smart date picker for check-in/check-out
- 👥 Guest count and room type selection
- 💳 Payment method selection (6 options)
- ✅ Booking confirmation with reference number
- 👤 User authentication (login/register/guest checkout)
- 📱 Cross-platform support (iOS, Android, Web, Linux, Windows)

## 🛠️ Tech Stack

- **Framework:** Flutter 3.44+
- **Language:** Dart 3.12+
- **HTTP Client:** http ^1.6.0
- **Fonts:** google_fonts ^8.2.0
- **Storage:** path_provider ^2.1.6
- **State Management:** Built-in StatefulWidget (can upgrade to Provider/Riverpod)
- **Architecture:** MVC pattern with separation of concerns

## 📁 Project Structure

```
frontend/lib/
├── main.dart                 # App entry point
├── screens/                  # App screens
│   ├── home_screen.dart     # Hotel listing
│   ├── hotel_detail_screen.dart
│   ├── booking_screen.dart
│   ├── payment_screen.dart
│   ├── confirmation_screen.dart
│   ├── login_screen.dart
│   └── profile_screen.dart
├── models/                   # Data models
│   ├── hotel.dart
│   ├── room.dart
│   ├── booking.dart
│   └── user.dart
├── services/                 # API & business logic
│   ├── api_client.dart
│   ├── hotel_service.dart
│   ├── booking_service.dart
│   └── auth_service.dart
├── widgets/                  # Reusable components
│   ├── hotel_card.dart
│   ├── room_card.dart
│   ├── button.dart
│   └── image_gallery.dart
└── config/                   # App configuration
    ├── theme.dart           # Colors, typography
    ├── api_config.dart      # API endpoints
    └── constants.dart       # Constants
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.44+ ([Install](https://flutter.dev/docs/get-started/install))
- Android SDK / Xcode (platform-specific)
- VS Code or Android Studio

### Installation

```bash
# Navigate to frontend directory
cd frontend

# Get dependencies
flutter pub get

# Generate code (if using any generators)
flutter pub run build_runner build

# Run the app
flutter run -d linux          # Linux
flutter run -d chrome         # Web browser
flutter run -d ios            # iOS simulator
flutter run -d android        # Android emulator
```

### Configuration

1. **Update API URL** in `lib/config/api_config.dart`:
```dart
static const String baseUrl = 'http://192.168.1.100:8080/api';
// Use 10.0.2.2:8080 for Android emulator
// Use localhost:8080 for desktop/web
```

2. **Verify Backend Connection**:
```bash
# In a separate terminal, start the backend server
cd backend
php spark serve
# Backend runs on http://localhost:8080
```

## 📦 Dependencies

### Current

```yaml
flutter:                       # Flutter framework
cupertino_icons: ^1.0.8       # iOS icons
http: ^1.6.0                  # HTTP requests
google_fonts: ^8.2.0          # Custom fonts
path_provider: ^2.1.6         # File system access
```

### Recommended Additions

```yaml
# State Management
provider: ^6.0.0              # Recommended for this project
# or
get: ^4.6.0                   # More powerful alternative

# API Client (replaces http for easier use)
dio: ^5.3.0                   # Advanced HTTP client

# Local Storage
sqflite: ^2.3.0               # SQLite database
shared_preferences: ^2.2.0    # Key-value storage

# Date & Time
intl: ^0.19.0                 # Internationalization

# UI Enhancements
cached_network_image: ^3.3.0  # Image caching
smooth_page_indicator: ^1.1.0 # Page indicators
shimmer: ^3.0.0               # Loading animations
lottie: ^2.7.0                # Smooth animations
```

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test --verbose

# Generate coverage
flutter test --coverage
```

## 🔌 API Integration

### Example: Fetching Hotels

```dart
// lib/services/hotel_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotelService {
  static const String baseUrl = 'http://localhost:8080/api';

  Future<List<Hotel>> getHotels() async {
    final response = await http.get(Uri.parse('$baseUrl/hotels'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((hotel) => Hotel.fromJson(hotel)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }
}
```

## 🎨 UI/UX Standards

- **Color Scheme:** Material Design 3 colors
- **Typography:** Google Fonts (Poppins for headers, Roboto for body)
- **Spacing:** 8dp grid system
- **Icons:** Material Icons + Cupertino Icons
- **Animations:** Smooth 300-500ms transitions
- **Responsiveness:** Mobile-first, tablet support

## 📱 Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Full Support | API 21+ (Android 5.0+) |
| iOS | ✅ Full Support | iOS 11.0+ |
| Web | 🔄 Ready | HTML5 rendering |
| Linux | ✅ Ready | GTK backend |
| Windows | ✅ Ready | Windows 7+ |
| macOS | ✅ Ready | macOS 10.11+ |

## 🚀 Build & Release

```bash
# Build APK (Android)
flutter build apk

# Build iOS app
flutter build ios

# Build Web
flutter build web

# Build Windows executable
flutter build windows

# Build Linux app
flutter build linux
```

## 📝 Code Standards

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use named parameters for clarity
- Add documentation comments to public methods
- Keep widgets under 300 lines
- Extract reusable widgets

```dart
// ✅ Good
class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onTap;

  const HotelCard({
    required this.hotel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

## 🔐 Security Notes

- Store API tokens in encrypted SharedPreferences
- Validate all user inputs
- Use HTTPS in production
- Don't expose API keys in code
- Implement SSL pinning for sensitive operations

## 🐛 Troubleshooting

### App not connecting to backend?
```
- Check if backend is running: curl http://localhost:8080/api/hotels
- Update API_BASE_URL in api_config.dart
- Check firewall/network settings
- Use 10.0.2.2:8080 for Android emulator
```

### Build errors?
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

## 🤝 Contributing

1. Create a feature branch: `git checkout -b feature/amazing-feature`
2. Follow code standards above
3. Test thoroughly: `flutter test`
4. Push and create a Pull Request

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design](https://material.io/design)
- [GetX Documentation](https://github.com/jonataslaw/getx)

## 📄 License

MIT License - See [LICENSE](../LICENSE) for details

---

**Built with ❤️ using Flutter**
