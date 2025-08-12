# SSLA School Mobile App

A comprehensive Flutter mobile application for SSLA School, built with modern architecture and state management.

## Features

### 🏠 Home Page
- School philosophy, vision, and mission
- Featured gallery images
- Student and parent testimonials
- Quick navigation to all sections

### ℹ️ About Us
- Detailed school information
- Philosophy, vision, and mission statements
- Contact information
- Comprehensive testimonials

### 📚 Courses Offered
- Primary Education (6 years)
- Secondary Education (4 years)
- Higher Secondary (2 years)
- Detailed course information with subjects and fees
- Course application functionality

### 🖼️ Gallery
- School infrastructure photos
- Facility images (labs, library, sports ground)
- Category-based filtering
- Image viewing with details

### 📞 Contact Us
- School contact information
- Interactive contact form
- Location placeholder for future map integration

### 📢 Notice Board
- School announcements and notices
- Category-based filtering (Academic, Events, Holiday, Sports)
- Important notice highlighting
- Attachment support (future implementation)

### 📅 Calendar
- School events and activities
- Monthly view with navigation
- Category-based filtering
- Event details and descriptions

### 📝 Registration
- Student registration form
- Course selection
- Parent/guardian information
- Form validation and submission

### 📋 Rules & Regulations
- Comprehensive school policies
- Academic rules and conduct guidelines
- Attendance and dress code policies
- Disciplinary procedures

## Technical Architecture

### State Management
- **Riverpod**: Modern state management solution
- Async state handling with loading, data, and error states
- Provider-based architecture for clean separation of concerns

### Navigation
- **GoRouter**: Declarative routing solution
- Deep linking support
- Type-safe navigation

### Data Models
- Structured data models for all entities
- JSON serialization support
- Type-safe data handling

### UI/UX
- Material Design 3 components
- Responsive layout design
- Consistent color scheme and typography
- Interactive elements with proper feedback

## Project Structure

```
lib/
├── models/           # Data models
├── providers/        # Riverpod state providers
├── screens/          # UI screens
├── widgets/          # Reusable UI components
├── services/         # Business logic services
├── utils/            # Utility functions
└── main.dart         # App entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd ssla_mobile
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Dependencies

The app uses the following key dependencies:

- **flutter_riverpod**: State management
- **go_router**: Navigation
- **cached_network_image**: Image caching
- **intl**: Internationalization
- **http**: HTTP requests (for future API integration)
- **shared_preferences**: Local storage
- **url_launcher**: External URL handling

## Data Sources

Currently, the app uses static data for demonstration purposes. All data is defined in the respective providers:

- School information
- Course details
- Gallery images
- Testimonials
- Notices and events

## Future Enhancements

### Backend Integration
- REST API integration for dynamic data
- Real-time notifications
- User authentication and profiles

### Additional Features
- Push notifications
- Offline data caching
- Multi-language support
- Dark mode theme
- Interactive maps integration
- File upload/download functionality

### Performance Optimizations
- Image lazy loading
- Data pagination
- Memory management
- App performance monitoring

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please contact:
- Email: info@sslaschool.edu
- Phone: +1 234 567 8900

## Screenshots

(Screenshots will be added here after the app is running)

---

**Built with ❤️ for SSLA School**
