# Unwind Yoga iOS App

A native iOS yoga application built with SwiftUI, designed to help users practice mindfulness and improve their physical health through guided yoga sessions.

## 📱 About

Unwind Yoga is a personal wellness app that provides:
- Daily personalized yoga sessions
- Comprehensive library of yoga poses
- Detailed pose instructions and benefits
- Progress tracking (coming soon)
- Beautiful, intuitive interface

## 🎯 Project Status

**Current Version**: v0.1.0 (MVP in Development)  
**Platform**: iOS 17.0+  
**Language**: Swift  
**Framework**: SwiftUI

### ✅ Implemented Features (v1.0)
- Welcome/Onboarding screens
- User authentication (local storage)
- Home screen with daily session recommendations
- Library with 12 yoga poses
- Search and filter functionality
- Detailed pose information with benefits
- Custom UI components matching brand design

### 🚧 In Progress
- Testing and refinement
- UI/UX polish

### 📋 Planned Features
- Active session with timer
- Progress tracking and streaks
- Daily reminder notifications
- Profile and settings
- Cloud sync
- Real yoga pose images/videos

## 🎨 Design

The app features a clean, modern design with:
- **Primary Color**: Rose Pink (#f43f5e)
- **Background**: Warm White (#FCF9F7)
- **Typography**: SF Pro (iOS system font)

Design files: [Figma](https://www.figma.com/proto/pmGweGuBu8uBrZrwGjXlnL/Unwind-Yoga-Design-final)

## 🏗️ Architecture

```
UnwindYoga/
├── Models/              # Data structures
│   ├── YogaPose.swift
│   ├── YogaSession.swift
│   └── User.swift
├── Views/               # UI screens
│   ├── Onboarding/
│   ├── Home/
│   ├── Library/
│   └── Components/
├── Services/            # Business logic
│   └── AuthService.swift
└── Utilities/           # Theme, extensions
    └── Theme.swift
```

## 🚀 Getting Started

### Prerequisites
- macOS with Xcode 15.0 or later
- iOS 17.0+ device or simulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/RahulSahastrabuddhe/unwind-yoga-ios.git
cd unwind-yoga-ios
```

2. Open the project in Xcode:
```bash
open UnwindYoga/UnwindYoga.xcodeproj
```

3. Select a simulator or device

4. Build and run (⌘R)

## 📚 Sample Data

The app includes 12 sample yoga poses:
- Mountain Pose (Tadasana)
- Downward-Facing Dog (Adho Mukha Svanasana)
- Warrior I & II (Virabhadrasana)
- Tree Pose (Vrksasana)
- Child's Pose (Balasana)
- Cobra Pose (Bhujangasana)
- And more...

## 🛠️ Tech Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **State Management**: Combine
- **Data Persistence**: UserDefaults (local)
- **Architecture**: MVVM-like pattern

## 📖 Documentation

- [Development Plan](PLAN.md) - Complete 7-phase development roadmap
- [Development Diary](DEVELOPMENT_DIARY.md) - Daily progress log
- [Setup Guide](UnwindYoga/README_XCODE_SETUP.md) - Xcode project setup instructions

## 🎯 Roadmap

### Phase 1-4: ✅ Complete
- Environment setup
- Project initialization
- Authentication & onboarding
- Main features (Home, Library, Pose details)

### Phase 5: 🚧 Next Up
- Active session with timer
- Progress tracking
- Profile screen
- Notifications

### Phase 6-7: 📋 Planned
- Testing and refinement
- App Store submission

## 🤝 Contributing

This is a personal learning project. Feedback and suggestions are welcome!

## 📄 License

This project is for personal use and learning purposes.

## 👤 Author

**Rahul Sahastrabuddhe**

## 🙏 Acknowledgments

- Design inspiration from modern wellness apps
- Yoga pose information from traditional yoga practices
- Built with the help of AI pair programming

## 📱 Screenshots

_Coming soon..._

---

**Note**: This is an MVP (Minimum Viable Product) in active development. Features and design are subject to change.

*Last Updated: November 9, 2025*
