# Unwind Yoga iOS App

A native iOS yoga application built with SwiftUI, designed to help users practice mindfulness and improve their physical health through guided yoga sessions.

## 📱 About

Unwind Yoga is a personal wellness app that provides:
- Daily personalized yoga sessions with video guidance
- Comprehensive library of yoga poses with detailed instructions
- Video demonstrations for each pose
- Progress tracking and session history
- Beautiful, intuitive interface

## 🎯 Project Status

**Current Version**: v1.1.0  
**Latest Update**: December 2025  
**Platform**: iOS 16.0+  
**Language**: Swift 5.0  
**Framework**: SwiftUI

### ✅ Implemented Features (v1.1.0)
- Video playback for yoga poses
- Full-screen video player with controls
- Daily session with 5 random poses
- Video indicators in library
- Smooth transitions between poses
- Enhanced error handling and debugging
- Sign In with Apple (local auth)
- Improved login UX with AutoFill and better keyboard behavior
- iOS 16.0+ support
- Removed non-functional Google Sign-In from UI for clean release
- **Dynamic progress tracking with real-time statistics**
- **Automatic daily activity tracking and streak calculation**
- **Session completion tracking with duration logging**
- **Interactive progress calendar with completed days visualization**

### ✅ Previous Features (v1.0)
- Welcome/Onboarding screens
- User authentication (local storage)
- Home screen with daily session recommendations
- Library with 20+ yoga poses
- Search and filter functionality
- Detailed pose information with benefits
- Custom UI components

### 🚧 In Progress
- Session history tracking
- User progress visualization
- Performance optimizations

## 🎨 Design

The app features a clean, modern design with:
- **Primary Color**: Rose Pink (#f43f5e)
- **Background**: Warm White (#FCF9F7)
- **Typography**: SF Pro (iOS system font)

## 🛠 Technical Details

### Architecture
- MVVM (Model-View-ViewModel) pattern
- SwiftUI for UI
- Combine for reactive programming
- AVKit for video playback

### Dependencies
- iOS 17.0+
- Xcode 15.0+
- Swift Package Manager

## 📸 Screenshots

| Home Screen | Pose Library | Video Player |
|-------------|--------------|--------------|
| <img src="screenshots/home.png" width="200"> | <img src="screenshots/library.png" width="200"> | <img src="screenshots/video_player.png" width="200"> |

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 16.0+ device or simulator
- CocoaPods (for future dependencies)

### Installation
1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/unwind-yoga-ios.git
   cd unwind-yoga-ios
   ```
2. Open `UnwindYoga.xcodeproj` in Xcode
3. Build and run the project (⌘R)

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

For any questions or feedback, please reach out to [your-email@example.com](mailto:your-email@example.com)

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
- iOS 16.0+ device or simulator

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
- **Progress Tracking**: Custom ProgressService with local storage

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

### Phase 6-7: ✅ Complete
- Testing and refinement
- App Store submission preparation
- Release-ready codebase (iOS 16.0+, auth fixes, UX polish)
- **🎉 SUBMITTED TO APP STORE FOR REVIEW** - January 18, 2026

### Current Status: Under Apple Review (Second Submission)
- **Review Timeline**: Typically 24-48 hours (up to 7 days)
- **Version**: v1.1.0 with dynamic progress tracking
- **Features**: Video playback, Apple Sign-In, daily sessions, real-time progress tracking
- **Recent Fixes**: Apple Sign-In bug resolved, dynamic stats implemented
- **Next**: Awaiting Apple approval for App Store launch

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

*Last Updated: January 21, 2026*
