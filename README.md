# 🏨 StayAddis - Hotel Booking System

A full-stack hotel booking application for Addis Ababa, built with **CodeIgniter 4** (backend API) and **Flutter** (mobile frontend). Browse hotels, explore rooms, and make instant bookings with multiple payment methods.

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)
![Platform](https://img.shields.io/badge/platform-Flutter%20%7C%20PHP-orange)

## ✨ Features

- 🏨 Browse 7 hotels with 73 real high-quality images
- 🖼️ View hotel details, room types, and immersive photo galleries
- 👥 Guest checkout (no login required) or register for account
- 📅 Smart booking with date picker, guest count, and room selection
- 💳 Multiple payment methods: Cash, TeleBirr, CBE Birr, Visa, Mastercard, Amex
- ✅ Booking confirmation with unique reference number
- 📱 Responsive, intuitive mobile UI with smooth animations
- 🔐 User registration and authentication

## 🛠️ Tech Stack

| Layer | Technology | Version |
|-------|------------|---------|
| Backend API | CodeIgniter | 4.7 |
| Language | PHP | 8.4 |
| Database | PostgreSQL | 18 |
| Mobile Frontend | Flutter | 3.44 |
| Language | Dart | Latest |
| State Management | Provider/GetX | - |
| Static Assets | Hotel Images (73) | Served via CI4 |

## 📁 Project Structure

```
stayaddis-hotel-booking/
├── app/
│   ├── Controllers/          # API endpoints & business logic
│   ├── Models/               # Database models (Hotel, User, Booking, etc.)
│   └── Database/
│       ├── Migrations/       # Schema definitions
│       └── Seeds/            # Sample data loaders
├── database/
│   └── schema/               # Database design & relationships
├── public/
│   └── assets/               # 73 hotel images & media files
├── frontend/
│   ├── lib/
│   │   ├── screens/          # UI screens (Home, Booking, Payment, etc.)
│   │   ├── models/           # Data models
│   │   ├── services/         # API client & business logic
│   │   ├── widgets/          # Reusable UI components
│   │   └── config/           # Theme, colors & API configuration
│   └── pubspec.yaml          # Flutter dependencies
├── tests/                    # Unit & integration tests
├── composer.json             # PHP dependencies
└── README.md
```

## 🚀 Quick Start

### Backend Setup

```bash
# Clone and navigate
git clone https://github.com/BereketWorana/stayaddis-hotel-booking.git
cd stayaddis-hotel-booking

# Configure environment
cp env .env
# Edit .env with PostgreSQL credentials:
# database.default.hostname = localhost
# database.default.database = stayaddis
# database.default.username = postgres
# database.default.password = your_password

# Run migrations & seeds
php spark migrate
php spark db:seed HotelSeeder
php spark db:seed RoomSeeder
php spark db:seed HotelImageSeeder
php spark db:seed UserSeeder
php spark db:seed BookingSeeder

# Start API server
php spark serve
# API runs on http://localhost:8080
```

### Frontend Setup

```bash
# Navigate to frontend
cd frontend

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run -d linux      # Linux
flutter run -d ios        # iOS
flutter run -d android    # Android
```

## 💾 Database Design

**6 Core Tables:**
- **hotels** - 3 premium + 4 basic hotels with location data
- **rooms** - Room types, pricing, capacity
- **hotel_images** - 73 high-quality hotel photos
- **room_images** - Room gallery images
- **users** - Guest accounts with auth
- **bookings** - Reservation records with status tracking

**Schema Relationships:**
```
hotels ──→ rooms ──→ bookings ← users
   ↓          ↓
 images     images
```

## 📱 API Endpoints (Examples)

```
GET    /api/hotels              # List all hotels
GET    /api/hotels/{id}         # Hotel details
GET    /api/hotels/{id}/rooms   # Rooms for hotel
POST   /api/users/register      # User registration
POST   /api/users/login         # User login
POST   /api/bookings            # Create booking
GET    /api/bookings/{id}       # Booking details
```

## 🎨 UI/UX Highlights

- Clean, modern card-based design
- Smooth animations & transitions
- Material Design principles
- Fully responsive layout
- Dark mode support (optional enhancement)
- Accessible color contrast ratios

## 📝 Scope & Architecture Notes

This MVP focuses on the **guest-centric booking flow** with a polished mobile interface:

- ✅ Hotel browsing and search
- ✅ Quick guest checkout (no login required)
- ✅ Full booking workflow
- ✅ Multiple payment method selection

**Design Decisions:**
- The `payments` table was intentionally folded into `bookings.status` for MVP simplicity
- In production, a dedicated `payments` table would track transaction history and audit trails
- User authentication uses session-based approach (can be upgraded to JWT for API scalability)

## 🧪 Testing

```bash
# Run PHPUnit tests (backend)
vendor/bin/phpunit

# Run Flutter tests
cd frontend
flutter test
```

## 📦 Dependencies

**Backend (PHP):**
- CodeIgniter 4.7 framework
- PostgreSQL 18 driver
- REST API utilities

**Frontend (Dart):**
- Flutter SDK 3.44+
- Provider (state management)
- Dio (HTTP client)
- intl (date formatting)

See `composer.json` and `pubspec.yaml` for full dependency lists.

## 🔐 Security Features

- ✅ Input validation on all endpoints
- ✅ CORS policies configured
- ✅ Password hashing with bcrypt
- ✅ SQL injection prevention (prepared statements)
- 🔄 Rate limiting (recommended for production)
- 🔄 JWT authentication (future enhancement)

## 🚀 Future Enhancements

- [ ] Real-time availability updates
- [ ] Advanced search filters (price range, amenities)
- [ ] User wishlist/favorites
- [ ] Booking cancellation & modifications
- [ ] Admin dashboard
- [ ] Email confirmations
- [ ] Payment gateway integration
- [ ] Review & rating system
- [ ] Loyalty program

## 🤝 Contributing

Contributions welcome! For major changes:
1. Fork the repo
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request



## 👤 Author

**Bereket Worana**  
📧 [My Email](bereketworana@gmail.com)  
🔗 [GitHub Profile](https://github.com/BereketWorana)

---

**⭐ If you found this helpful, please give it a star!**
