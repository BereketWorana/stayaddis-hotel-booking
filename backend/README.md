# StayAddis - Hotel Booking System

A full-stack hotel booking application for Addis Ababa, built with **CodeIgniter 4** (backend API) and **Flutter** (mobile frontend).

## Tech Stack

| Layer | Technology |
|-------|------------|
| Backend | PHP 8.4, CodeIgniter 4.7 |
| Database | PostgreSQL 18 |
| Frontend | Flutter 3.44, Dart |
| Images | 73 real hotel photos, served via CI4 |

## Features

- Browse 7 hotels with real images
- View hotel details, room types, and photo galleries
- Guest checkout (no login required)
- User registration and login
- Booking with date picker, guest count, and payment method selection
- Booking confirmation with unique reference number
- Payment methods: Cash, TeleBirr, CBE Birr, Visa, Mastercard, Amex

## Project Structure

\`\`\`
stayaddis-hotel-booking/
├── backend/              # CodeIgniter 4 API
│   ├── app/Controllers/  # API controllers
│   ├── app/Models/       # Database models
│   ├── app/Database/     # Migrations & seeders
│   └── public/assets/    # Hotel images
├── frontend/             # Flutter mobile app
│   ├── lib/screens/      # App screens
│   └── lib/config/       # Theme & API config
└── README.md
\`\`\`

## Setup

### Backend
\`\`\`bash
cd backend
cp env .env
# Edit .env with your database credentials
php spark migrate
php spark db:seed HotelSeeder
php spark db:seed UserSeeder
php spark db:seed RoomSeeder
php spark db:seed HotelImageSeeder
php spark db:seed BookingSeeder
php spark serve
\`\`\`

### Frontend
\`\`\`bash
cd frontend
flutter pub get
flutter run -d linux
\`\`\`

## Database

6 tables: hotels, hotel_images, users, rooms, room_images, bookings

3 premium hotels (full details) + 4 basic hotels (lightweight data)

## Scope Notes

This MVP focuses on the guest booking flow with a polished mobile UI. The \`payments\` table was intentionally folded into \`bookings.status\` for demo simplicity — a dedicated payments table would be added in production for transaction history and audit trails.

## License

MIT
