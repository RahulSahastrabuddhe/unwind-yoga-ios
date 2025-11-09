# Unwind Yoga iOS App - Development Plan

## Project Overview
Building a native iOS yoga app for the Apple App Store based on Figma designs.

**Goal**: Deploy a fully functional yoga app to the Apple App Store

**Timeline**: 8-10 weeks

---

## Division of Responsibilities

### **You Handle:**
1. ✅ Install Xcode
2. ✅ Create Apple Developer account
3. ✅ Create Xcode project (I'll guide you step-by-step)
4. ✅ Provide Figma assets (images, icons, colors)
5. ✅ Test the app on your device
6. ✅ Submit to App Store (with my guidance)

### **I Handle:**
1. ✅ Write ALL Swift/SwiftUI code
2. ✅ Create all views, models, and logic
3. ✅ Implement features matching your Figma design
4. ✅ Debug and fix issues
5. ✅ Explain what each piece of code does

---

## App Screens (From Figma)

Based on your Figma design, the app includes:

1. **Welcome Page** - Onboarding with Terms of Use/Privacy Policy
2. **Login/Signup Page** - Authentication with email/password
3. **Terms of Use** - Legal content
4. **Privacy Policy** - Legal content  
5. **Home Screen** - Daily session recommendations
6. **Library** - Browse yoga poses
7. **Progress** - Track user progress (0/5 shown)
8. **Profile** - User settings and account
9. **Notification Permission** - Request for daily reminders
10. **Personalization** - User preferences setup
11. **Session Details** - Yoga session information
12. **Active Session** - Practice mode with timer
13. **Tab Navigation** - Bottom navigation bar

---

## Development Timeline (8-10 weeks)

| Phase | Duration | You Do | I Do |
|-------|----------|--------|------|
| **Phase 1: Setup** | Week 1 | Install Xcode, enroll in Apple Developer, export Figma assets | Guide you through setup |
| **Phase 2: Project Init** | Week 1 | Create Xcode project following my instructions | Provide exact steps, verify setup |
| **Phase 3: Auth & Onboarding** | Week 2-3 | Test screens as I build them | Code Welcome, Login, Onboarding screens |
| **Phase 4: Main Features** | Week 4-6 | Test features, provide feedback | Code Home, Library, Profile, Tab Navigation |
| **Phase 5: Sessions & Progress** | Week 7-8 | Test sessions and progress tracking | Code Session flow, Progress tracking, Notifications |
| **Phase 6: Testing** | Week 9 | Test on device, report bugs | Fix bugs, polish UI |
| **Phase 7: App Store** | Week 10 | Submit to App Store | Guide submission process |

---

## Phase 1: Setup & Prerequisites (Week 1)

### 1.1 Development Environment
- [ ] **Install Xcode** (latest version from Mac App Store)
  - Requires macOS and ~15GB disk space
  - Download link: Mac App Store → Search "Xcode"
- [ ] **Verify Xcode installation**
  - Open Xcode, accept license agreement
  - Install additional components when prompted
- [ ] **Install Xcode Command Line Tools**
  ```bash
  xcode-select --install
  ```

### 1.2 Apple Developer Account
- [ ] **Enroll in Apple Developer Program** ($99/year)
  - Visit: https://developer.apple.com/programs/
  - Use your Apple ID
  - Processing takes 24-48 hours
- [ ] **Set up certificates and provisioning profiles** (we'll do this in Phase 6)

### 1.3 Design Assets Preparation
- [ ] **Export assets from Figma**
  - Export all images at @1x, @2x, @3x resolutions
  - Export icons in required sizes (20x20, 29x29, 40x40, 60x60, 76x76, 83.5x83.5, 1024x1024)
  - Export app icon as 1024x1024 PNG (no transparency)
- [ ] **Prepare yoga content**
  - Collect/create yoga pose images
  - Write pose descriptions and instructions
  - Prepare session content (durations, sequences)
- [ ] **Color palette & fonts**
  - Document exact colors from Figma (hex codes)
  - Identify fonts used (system fonts recommended for iOS)

---

## Phase 2: Project Setup (Week 1-2)

### 2.1 Create Xcode Project
- [ ] **Initialize project**
  - Open Xcode → Create New Project
  - Choose "iOS" → "App"
  - Product Name: "Unwind Yoga"
  - Interface: SwiftUI
  - Language: Swift
  - Storage: SwiftData (or Core Data)
- [ ] **Configure project settings**
  - Bundle Identifier: `com.yourname.unwindyoga`
  - Team: Select your Apple Developer account
  - Deployment Target: iOS 17.0 (or latest)

### 2.2 Project Structure
```
UnwindYoga/
├── App/
│   ├── UnwindYogaApp.swift (main entry point)
│   └── ContentView.swift
├── Models/
│   ├── YogaPose.swift
│   ├── YogaSession.swift
│   ├── User.swift
│   └── Progress.swift
├── Views/
│   ├── Onboarding/
│   │   ├── WelcomeView.swift
│   │   ├── LoginView.swift
│   │   ├── SignUpView.swift
│   │   └── PersonalizationView.swift
│   ├── Home/
│   │   ├── HomeView.swift
│   │   └── DailySessionCard.swift
│   ├── Library/
│   │   ├── LibraryView.swift
│   │   └── PoseDetailView.swift
│   ├── Progress/
│   │   └── ProgressView.swift
│   ├── Profile/
│   │   └── ProfileView.swift
│   └── Components/
│       ├── CustomButton.swift
│       ├── CustomTextField.swift
│       └── TabBarView.swift
├── ViewModels/
│   ├── AuthViewModel.swift
│   ├── SessionViewModel.swift
│   └── ProgressViewModel.swift
├── Services/
│   ├── AuthService.swift
│   ├── NotificationService.swift
│   └── DataService.swift
├── Utilities/
│   ├── Constants.swift
│   ├── Extensions.swift
│   └── Theme.swift
└── Resources/
    ├── Assets.xcassets
    └── Data/
        └── yoga_poses.json
```

---

## Phase 3: Authentication & Onboarding (Week 2-3)

### Features to Build:
- [ ] **Welcome Screen**
  - Hero image
  - "Continue" button
  - Terms of Use & Privacy Policy links
- [ ] **Login/Signup Screen**
  - Email/Username input
  - Password input with show/hide toggle
  - Login button
  - Sign Up button
  - Social login buttons (Google, Apple)
  - "Forgot Password?" link
- [ ] **Authentication Logic**
  - For MVP: Use UserDefaults (local only)
  - Future: Integrate Firebase Auth or similar
- [ ] **Terms & Privacy Screens**
  - ScrollView with legal text
  - Back button
- [ ] **Personalization screens**
  - Goal selection (flexibility, strength, mindfulness, weight loss)
  - Experience level selection
  - Preferred practice time
  - Notification permission request

---

## Phase 4: Main Features (Week 4-6)

### 4.1 Main Tab Navigation
- [ ] **Tab Bar**
  - Home tab
  - Library tab
  - Progress tab
  - Profile tab
  - Custom pink accent color for selected tab

### 4.2 Home Screen
- [ ] **Daily Session Card**
  - Display recommended session
  - Session duration (e.g., "15 min")
  - "Start" button
  - Background image
- [ ] **Greeting** ("Good evening!")
- [ ] **Notification & Settings icons**
- [ ] **"Browse More Poses" button**

### 4.3 Library Screen
- [ ] **Pose List**
  - Scrollable list of yoga poses
  - Each item: pose name, image, difficulty level
  - Search functionality
  - Filter by category/difficulty
- [ ] **Pose Detail View**
  - Large pose image
  - Pose name
  - Instructions
  - Benefits
  - Duration/hold time
  - "Add to Favorites" button

### 4.4 Profile Screen
- [ ] **User Info**
  - Profile picture (optional)
  - Name
  - Email
- [ ] **Settings**
  - Account settings
  - Notification preferences
  - Practice reminders
  - Theme settings (if applicable)
  - Privacy & Terms links
- [ ] **Logout button**

---

## Phase 5: Sessions & Progress (Week 7-8)

### 5.1 Session Flow
- [ ] **Session Detail Screen**
  - Session name
  - Duration
  - Pose sequence list
  - "Start Session" button
- [ ] **Active Session Screen**
  - Current pose display
  - Timer/countdown
  - Progress indicator
  - "Next" and "Previous" buttons
  - "Pause" and "End Session" buttons
- [ ] **Session Complete Screen**
  - Congratulations message
  - Session summary
  - "Done" button

### 5.2 Progress Screen
- [ ] **Progress Dashboard**
  - Circular progress indicator (0/5 shown in Figma)
  - Calendar view showing practice days
  - Streak counter
  - Total sessions completed
  - Total practice time
- [ ] **Progress Tracking Logic**
  - Save completed sessions
  - Calculate streaks
  - Update progress data

### 5.3 Notifications
- [ ] **Request notification permission**
  - Show permission dialog
  - Handle user response
- [ ] **Schedule daily reminders**
  - Use UNUserNotificationCenter
  - Schedule based on user's preferred time
  - Custom notification content
- [ ] **Handle notification taps**
  - Deep link to appropriate screen

---

## Phase 6: Testing & Refinement (Week 9)

### 6.1 Testing on Simulator
- [ ] **Test all screens**
  - Navigate through entire app flow
  - Test all buttons and interactions
  - Verify data persistence
- [ ] **Test different device sizes**
  - iPhone SE (small)
  - iPhone 15 Pro (standard)
  - iPhone 15 Pro Max (large)
- [ ] **Test edge cases**
  - Empty states (no sessions, no progress)
  - Error handling
  - Network issues (if applicable)

### 6.2 Testing on Physical Device
- [ ] **Connect iPhone to Mac**
- [ ] **Run app on device**
  - Xcode → Select your device
  - Click Run (⌘R)
- [ ] **Test notifications**
  - Schedule test notification
  - Verify it appears
  - Test notification tap behavior
- [ ] **Test performance**
  - Check for lag or crashes
  - Monitor memory usage

### 6.3 UI/UX Refinement
- [ ] **Match Figma designs**
  - Compare side-by-side with Figma
  - Adjust colors, spacing, fonts
  - Ensure consistency
- [ ] **Animations & transitions**
  - Add smooth transitions between screens
  - Button press animations
  - Loading states
- [ ] **Accessibility**
  - Add VoiceOver support
  - Test with Dynamic Type
  - Ensure sufficient color contrast

---

## Phase 7: App Store Submission (Week 10)

### 7.1 App Store Assets
- [ ] **App Icon**
  - 1024x1024 PNG (no transparency, no rounded corners)
  - Add to Assets.xcassets
- [ ] **Screenshots** (required for all device sizes)
  - iPhone 6.7" (iPhone 15 Pro Max): 1290 x 2796
  - iPhone 6.5" (iPhone 11 Pro Max): 1242 x 2688
  - iPhone 5.5" (iPhone 8 Plus): 1242 x 2208
  - Take 3-5 screenshots showing key features
- [ ] **App Preview Video** (optional but recommended)
  - 15-30 second video
  - Show app in action

### 7.2 App Store Listing Content
- [ ] **App Name**: "Unwind Yoga"
- [ ] **Subtitle** (30 chars): "Daily Mindful Practice"
- [ ] **Description** (4000 chars max)
  ```
  Unwind Yoga brings mindfulness and wellness to your daily routine. 
  Whether you're a beginner or experienced yogi, our app guides you 
  through personalized yoga sessions designed for your goals.
  
  FEATURES:
  • Daily personalized yoga sessions
  • Comprehensive pose library with detailed instructions
  • Progress tracking and streak monitoring
  • Customizable practice reminders
  • Beautiful, intuitive interface
  
  Start your journey to better health and mindfulness today!
  ```
- [ ] **Keywords** (100 chars): "yoga,meditation,wellness,fitness,mindfulness,health,exercise,stretching"
- [ ] **Support URL**: Your website or email
- [ ] **Privacy Policy URL**: Required (create simple privacy policy)

### 7.3 App Store Connect Setup
- [ ] **Log in to App Store Connect**
  - https://appstoreconnect.apple.com
- [ ] **Create new app**
  - Click "My Apps" → "+" → "New App"
  - Platform: iOS
  - Name: Unwind Yoga
  - Primary Language: English
  - Bundle ID: Select your bundle ID
  - SKU: unwindyoga001
- [ ] **Fill in app information**
  - Category: Health & Fitness
  - Subcategory: Fitness
  - Content Rights: You own rights
- [ ] **Set pricing**
  - Free (for MVP)
  - Or set price if premium

### 7.4 Privacy & Compliance
- [ ] **Privacy Policy**
  - Create simple privacy policy
  - Host on website or GitHub Pages
  - Add URL to App Store listing
- [ ] **Privacy Nutrition Label**
  - In App Store Connect, fill out privacy questions
  - For basic app: likely "No data collected"
- [ ] **Export Compliance**
  - Answer encryption questions (usually "No" for basic apps)

### 7.5 Build & Upload
- [ ] **Version & Build Numbers**
  - Version: 1.0.0
  - Build: 1
- [ ] **App Signing**
  - Xcode → Signing & Capabilities
  - Enable "Automatically manage signing"
  - Select your team
- [ ] **Archive Build**
  - Xcode → Product → Archive
  - Wait for archive to complete
- [ ] **Distribute app**
  - In Archives window, click "Distribute App"
  - Choose "App Store Connect"
  - Click "Upload"
  - Wait for processing (10-30 minutes)

### 7.6 Submit for Review
- [ ] **Complete all required fields**
  - Screenshots uploaded
  - Description filled
  - Keywords added
  - Privacy policy URL
  - Support URL
- [ ] **Submit for review**
  - Click "Submit for Review"
  - Answer additional questions
  - Confirm submission
- [ ] **Wait for review**
  - Typically 24-48 hours
  - Check email for updates

### 7.7 Handle Review & Release
- [ ] **If approved**: Celebrate! 🎉
- [ ] **If rejected**:
  - Read rejection reason carefully
  - Fix issues
  - Resubmit
- [ ] **Choose release option**
  - Automatic release (goes live immediately after approval)
  - Manual release (you control when)
- [ ] **Monitor initial reviews**
  - Check App Store reviews
  - Respond to user feedback
  - Plan updates based on feedback

---

## Information Needed to Start Coding

### 1. Color Palette from Figma
- Primary color (the pink): `#______`
- Background: `#______`
- Text primary: `#______`
- Text secondary: `#______`
- Any other brand colors: `#______`

### 2. App Icon
- Upload the 1024x1024 PNG file

### 3. Yoga Content
- How many yoga poses for MVP? (suggest 10-20)
- Do you have pose images, or should I use placeholders?
- Do you have pose descriptions, or should I create sample content?

### 4. Feature Priority
- Which features are MUST-HAVE for v1.0?
- Which can wait for v1.1 updates?

### 5. Setup Status
- [ ] Xcode installed?
- [ ] Apple Developer Program enrolled?
- [ ] Figma assets exported?

---

## Key Resources

### Learning (Optional - for understanding)
- **Apple's Swift Documentation**: https://docs.swift.org/swift-book/
- **SwiftUI Tutorials**: https://developer.apple.com/tutorials/swiftui
- **Hacking with Swift**: https://www.hackingwithswift.com/100/swiftui

### Development
- **Apple Developer Documentation**: https://developer.apple.com/documentation/
- **Human Interface Guidelines**: https://developer.apple.com/design/human-interface-guidelines/
- **SF Symbols**: https://developer.apple.com/sf-symbols/ (free icon library)

### App Store
- **App Store Review Guidelines**: https://developer.apple.com/app-store/review/guidelines/
- **App Store Connect**: https://appstoreconnect.apple.com

---

## How We'll Work Together

### Workflow:
1. **I'll create code files** for you
2. **You'll copy-paste** them into Xcode
3. **You'll test** on simulator/device
4. **You'll give feedback** ("this button doesn't work", "colors are off", etc.)
5. **I'll fix/adjust** the code
6. **Repeat** until complete

### Communication:
When you need help, tell me:
- What you're trying to do
- What's happening (error messages, screenshots)
- What you expected to happen

---

## Current Status

- [ ] Phase 1: Setup & Prerequisites
- [ ] Phase 2: Project Initialization
- [ ] Phase 3: Authentication & Onboarding
- [ ] Phase 4: Main Features
- [ ] Phase 5: Sessions & Progress
- [ ] Phase 6: Testing & Refinement
- [ ] Phase 7: App Store Submission

---

## Next Immediate Steps

1. **Install Xcode** (if not done)
2. **Enroll in Apple Developer Program** (start now, takes 24-48 hours)
3. **Extract colors from Figma**
4. **Export app icon (1024x1024 PNG)**
5. **Decide on yoga content** (poses, images, descriptions)
6. **Provide the information needed above**

Once you complete these steps, we'll start building the app!

---

**Last Updated**: November 2, 2025
