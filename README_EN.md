# Almost Due 📅

A cute expiry date management app to help you track the shelf life of food and items, reducing waste.

[简体中文](./README.md) | English

## ✨ Feature

- **🧸 Fresh & Cute UI** - Thoughtfully designed interface that makes managing expiry dates fun
- **📝 Manual Entry** - Quickly add item name, expiry date, and notes
- **🤖 AI Recognition** - Support for AI-powered automatic item information recognition
- **⏰ Expiry Reminders** - Customizable reminder days before expiration (default: 3 days)
- **📊 Status Overview** - Home page displays counts for expired, expiring soon, and safe items
- **💾 Local Storage** - Data is securely stored on your device

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) 3.10+
- **State Management**: [Riverpod](https://riverpod.dev/) 3.x (with code generation)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Fonts**: [Google Fonts](https://pub.dev/packages/google_fonts)

## 📁 Project Structure

```
lib/
├── app/              # App configuration, routing, theme
├── data/
│   ├── models/       # Data models (ExpiryItem, AppSettings)
│   └── services/     # Data services (StorageService)
├── state/            # Riverpod state management
├── ui/
│   ├── screens/      # Screens (Home, Add Item, Settings)
│   └── widgets/      # Reusable components
├── utils/            # Utility functions
└── main.dart         # Entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.10.4 or higher
- Dart SDK 3.0 or higher

### Installation & Running

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd almost_due_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (Riverpod)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Development Mode

Enable code generation watcher for real-time updates:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

## ⚙️ Configuration

### AI Features

Configure the AI interface in the Settings page:
- **API Base URL**: Your AI service endpoint
- **API Key**: The corresponding API key

### Reminder Days

Adjust the number of days for advance reminders in Settings. Default is 3 days.

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 📄 License

MIT License
