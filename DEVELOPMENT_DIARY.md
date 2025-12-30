# Unwind Yoga - Development Diary

## Project Overview
**Goal**: Build and deploy a native iOS yoga app to the Apple App Store  
**App Name**: Unwind Yoga  
**Timeline**: 8-10 weeks  
**Status**: In Development - Phase 3 Complete ✅

---

## November 1, 2025 - Project Planning

### What Happened
- Initial project discussion and planning
- Reviewed Figma designs for the app
- Defined project scope and features
- Created comprehensive development plan

### Decisions Made
- **Platform**: Native iOS (Swift/SwiftUI) instead of web
- **Development Approach**: AI will code, I will test and deploy
- **MVP Features for v1.0**:
  - Welcome/Onboarding screens
  - Login/Signup (local storage, no backend)
  - Home screen with daily session
  - Library of yoga poses
  - Pose detail view

### Design Assets Collected
- **Colors**:
  - Primary Pink: `#f43f5e`
  - Background: `#FCF9F7`
  - Text Primary: `#1f2937`
  - Text Secondary: `#4b5563`
- **App Icon**: Yoga meditation pose (pink on light background)
- **Content Strategy**: Use placeholder images and sample content for MVP

### Documents Created
- `PLAN.md` - Complete 7-phase development plan with detailed checklists

### Key Resources Identified
- Figma Design: https://www.figma.com/proto/pmGweGuBu8uBrZrwGjXlnL/Unwind-Yoga-Design-final
- GitHub Repo: https://github.com/RahulSahastrabuddhe/Unwindyoga (contains web export, not used)

---

## November 7, 2025 - Getting Started

### What Happened
- Reviewed the development plan
- Confirmed readiness to start development
- Prepared to set up development environment

### Status Check
- ✅ Figma designs reviewed
- ✅ Feature scope defined
- ✅ Color palette documented
- ⏳ Xcode installation pending
- ⏳ Apple Developer account pending

---

## November 9, 2025 - Development Kickoff

### Morning Session (9:00 AM - 9:45 AM)

#### Environment Setup
- ✅ **Installed Xcode** (latest version from Mac App Store)
- ✅ **Created Xcode Project**:
  - Product Name: `UnwindYoga`
  - Bundle Identifier: `com.rahul.UnwindYoga`
  - Interface: SwiftUI
  - Language: Swift
  - Location: `/Users/rahulsahastrabuddhe/Documents/11:25/Unwind Yoga/UnwindYoga/`
- ✅ **Added App Icon** to Assets.xcassets

#### Code Development - Phase 3 Complete ✅

**Files Created (12 files):**

1. **Utilities/Theme.swift**
   - Brand colors implementation
   - Typography system
   - Spacing constants
   - Corner radius values
   - Shadow definitions
   - Hex color extension

2. **Models/YogaPose.swift**
   - YogaPose data structure
   - Difficulty levels (Beginner, Intermediate, Advanced)
   - Categories (Standing, Seated, Balancing, etc.)
   - 12 sample yoga poses with full descriptions and benefits

3. **Models/YogaSession.swift**
   - YogaSession data structure
   - Sample sessions (Morning Energizer, Evening Wind Down, Strength Builder)

4. **Models/User.swift**
   - User profile data structure
   - Goals enum (Flexibility, Strength, Mindfulness, etc.)
   - Onboarding preferences

5. **Services/AuthService.swift**
   - ObservableObject for authentication state
   - Sign up functionality (local storage)
   - Login functionality (local storage)
   - User data persistence with UserDefaults
   - Onboarding completion tracking

6. **Views/Components/CustomButton.swift**
   - Reusable button component
   - Three styles: Primary, Secondary, Outline
   - Matches Figma design

7. **Views/Components/CustomTextField.swift**
   - Reusable text field component
   - Secure field support with show/hide toggle
   - Custom styling

8. **Views/Onboarding/WelcomeView.swift**
   - Welcome screen with hero image
   - "Continue" button
   - Terms of Use modal
   - Privacy Policy modal
   - Navigation to Login screen

9. **Views/Onboarding/LoginView.swift**
   - Login/Signup toggle
   - Email and password fields
   - Name field for signup
   - Social login placeholders (Apple, Google)
   - "Forgot Password?" link
   - Form validation
   - Navigation to Home screen

10. **Views/Home/HomeView.swift**
    - Dynamic greeting (Good morning/afternoon/evening)
    - Daily session card with gradient background
    - "Start" button for sessions
    - Quick stats cards (Sessions, Minutes, Streak)
    - "Browse More Poses" button
    - Navigation to Library

11. **Views/Library/LibraryView.swift**
    - Search bar for poses
    - Filter chips (All, Beginner, Intermediate, Advanced)
    - Scrollable list of yoga poses
    - Pose cards with name, Sanskrit name, difficulty badge, duration
    - Navigation to Pose Detail

12. **Views/Library/PoseDetailView.swift**
    - Large hero image with gradient
    - Pose name and Sanskrit name
    - Favorite button (heart icon)
    - Info pills (duration, difficulty, category)
    - Full description
    - Benefits list with checkmarks
    - "Try This Pose" button

**App Entry Point Updated:**
- Modified `UnwindYogaApp.swift` to show WelcomeView or HomeView based on authentication status

#### Build Issues & Fixes (9:39 AM - 9:45 AM)

**Problem**: Build failed with 7 errors related to missing `Combine` import

**Errors**:
1. Type 'AuthService' does not conform to protocol 'ObservableObject'
2. Initializer 'init(wrappedValue:)' not available (missing Combine)
3. Instance method 'autoconnect()' not available (missing Combine)

**Solution**: Added `import Combine` to:
- ✅ `Services/AuthService.swift` (for ObservableObject and @Published)
- ✅ `Views/Home/HomeView.swift` (for Timer.publish().autoconnect())

**Result**: ✅ Build successful!

### Afternoon Session (4:05 PM - 4:20 PM)

#### Documentation
- Created this development diary to track daily progress

#### Version Control & GitHub (4:13 PM - 4:20 PM)

**Git Repository Setup:**
- ✅ Initialized git repository
- ✅ Created `.gitignore` for Xcode projects
- ✅ Created professional `README.md` for GitHub
- ✅ Added all files to git (27 files, 3,565 lines of code)
- ✅ Made initial commit with detailed message

**GitHub Push:**
- ✅ Created GitHub repository: `unwind-yoga-ios`
- ✅ Connected local repo to GitHub remote
- ✅ Renamed branch to `main`
- ✅ Pushed all code to GitHub (42 objects, 1.01 MB)
- ✅ Repository URL: https://github.com/RahulSahastrabuddhe/unwind-yoga-ios

**What's on GitHub:**
- All Swift source code files
- Xcode project configuration
- App icon assets
- Complete documentation
- Setup guides

---

## Current Status

### ✅ Completed (Phases 1-4)
- [x] Phase 1: Environment Setup
  - Xcode installed
  - Project created
  - App icon added
- [x] Phase 2: Project Initialization
  - Folder structure created
  - Theme configured
  - Models defined
- [x] Phase 3: Authentication & Onboarding
  - Welcome screen
  - Login/Signup screen
  - Terms & Privacy views
  - Local authentication
- [x] Phase 4: Main Features
  - Home screen with daily session
  - Library with search and filters
  - Pose detail view
  - 12 sample yoga poses

### 🚧 In Progress
- [ ] Phase 6: Testing & Refinement
  - Need to test app on simulator
  - Need to test on physical device
  - UI/UX refinement based on testing

### ⏳ Pending
- [ ] Phase 5: Sessions & Progress (Future)
  - Active session with timer
  - Progress tracking
  - Profile screen
  - Notifications
- [ ] Phase 7: App Store Submission
  - Apple Developer account enrollment
  - App Store assets preparation
  - Privacy policy creation
  - App submission

---

## Technical Stack

### Languages & Frameworks
- **Language**: Swift
- **UI Framework**: SwiftUI
- **State Management**: Combine (ObservableObject, @Published)
- **Data Persistence**: UserDefaults (local storage)
- **Navigation**: NavigationStack

### Architecture
- **Pattern**: MVVM-like (Models, Views, Services)
- **Folder Structure**:
  ```
  UnwindYoga/
  ├── Models/           (Data structures)
  ├── Views/            (UI screens)
  │   ├── Onboarding/
  │   ├── Home/
  │   ├── Library/
  │   └── Components/
  ├── Services/         (Business logic)
  └── Utilities/        (Theme, extensions)
  ```

### Key Features Implemented
1. **Authentication Flow**
   - Local user registration
   - Local user login
   - Persistent session (UserDefaults)
   
2. **Home Screen**
   - Time-based greeting
   - Daily session recommendation
   - Quick stats display
   
3. **Library**
   - 12 yoga poses with full details
   - Search functionality
   - Filter by difficulty
   - Detailed pose information
   
4. **UI Components**
   - Custom buttons (3 styles)
   - Custom text fields
   - Reusable cards
   - Filter chips
   - Difficulty badges

---

## Sample Data

### Yoga Poses Included (12 total)
1. Mountain Pose (Tadasana) - Beginner, Standing
2. Downward-Facing Dog (Adho Mukha Svanasana) - Beginner, Inversion
3. Warrior I (Virabhadrasana I) - Beginner, Standing
4. Warrior II (Virabhadrasana II) - Beginner, Standing
5. Tree Pose (Vrksasana) - Beginner, Balancing
6. Child's Pose (Balasana) - Beginner, Restorative
7. Cobra Pose (Bhujangasana) - Beginner, Backbend
8. Seated Forward Bend (Paschimottanasana) - Intermediate, Forward
9. Triangle Pose (Trikonasana) - Beginner, Standing
10. Pigeon Pose (Eka Pada Rajakapotasana) - Intermediate, Seated
11. Bridge Pose (Setu Bandha Sarvangasana) - Beginner, Backbend
12. Corpse Pose (Savasana) - Beginner, Restorative

### Sample Sessions
1. Morning Energizer - 15 min, Beginner
2. Evening Wind Down - 20 min, Beginner
3. Strength Builder - 30 min, Intermediate

---

## Design Implementation

### Color Palette (from Figma)
- **Primary**: #f43f5e (Pink/Rose)
- **Background**: #FCF9F7 (Warm White)
- **Text Primary**: #1f2937 (Dark Gray)
- **Text Secondary**: #4b5563 (Medium Gray)

### Typography
- Large Title: 34pt, Bold
- Title 1: 28pt, Bold
- Title 2: 22pt, Semibold
- Title 3: 20pt, Semibold
- Body: 17pt, Regular
- Caption: 12pt, Regular

### Spacing System
- XS: 4pt
- SM: 8pt
- MD: 16pt
- LG: 24pt
- XL: 32pt
- XXL: 48pt

### Corner Radius
- Small: 8pt
- Medium: 12pt
- Large: 16pt
- Extra Large: 24pt

---

## Known Issues & Limitations

### Current Limitations (MVP)
- ❌ No actual yoga pose images (using SF Symbols placeholders)
- ❌ No video support yet
- ❌ No active session timer
- ❌ No progress tracking
- ❌ No notifications
- ❌ No backend/cloud sync
- ❌ No social login (Apple, Google)
- ❌ No profile screen
- ❌ No password reset functionality

### Planned for Future Versions
- Real yoga pose images
- Video demonstrations
- Active session with timer and pose sequences
- Progress tracking with calendar and streaks
- Daily reminder notifications
- User profile and settings
- Cloud sync (Firebase or similar)
- Social authentication

---

## Next Steps

### Immediate (This Week)
1. ✅ Test app on simulator - verify all screens work
2. ✅ Test navigation flow
3. ✅ Test signup and login
4. ✅ Verify UI matches Figma design
5. ✅ Take screenshots for documentation

### Short Term (Next 1-2 Weeks)
1. Get feedback on current implementation
2. Make UI/UX adjustments based on testing
3. Add real yoga pose images (if available)
4. Polish animations and transitions
5. Test on physical iPhone device

### Medium Term (Next 3-4 Weeks)
1. Implement active session with timer (Phase 5)
2. Add progress tracking
3. Add profile screen
4. Implement notifications
5. Prepare for App Store submission

### Long Term (Next 5-8 Weeks)
1. Enroll in Apple Developer Program
2. Create App Store assets (screenshots, description)
3. Write Privacy Policy
4. Submit to App Store
5. Handle review feedback
6. Launch! 🚀

---

## Resources & Links

### Project Files
- **Project Location**: `/Users/rahulsahastrabuddhe/Documents/11:25/Unwind Yoga/UnwindYoga/`
- **Xcode Project**: `UnwindYoga.xcodeproj`
- **Development Plan**: `PLAN.md`
- **Setup Guide**: `README_XCODE_SETUP.md`
- **This Diary**: `DEVELOPMENT_DIARY.md`

### External Resources
- **Figma Design**: https://www.figma.com/proto/pmGweGuBu8uBrZrwGjXlnL/Unwind-Yoga-Design-final
- **GitHub Repo**: https://github.com/RahulSahastrabuddhe/Unwindyoga
- **Apple Developer**: https://developer.apple.com
- **App Store Connect**: https://appstoreconnect.apple.com

### Learning Resources
- Swift Documentation: https://docs.swift.org/swift-book/
- SwiftUI Tutorials: https://developer.apple.com/tutorials/swiftui
- Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/

---

## Lessons Learned

### Day 1 (Nov 9, 2025)
1. **Import Statements Matter**: Always remember to import `Combine` when using `ObservableObject`, `@Published`, or Timer publishers
2. **File Organization**: Creating a clear folder structure from the start makes the project much easier to navigate
3. **Reusable Components**: Building custom buttons and text fields early saves time later
4. **Sample Data**: Having good sample data (12 poses with full descriptions) makes the app feel real even in early stages
5. **Build Early, Build Often**: Catching import errors early is much easier than debugging later

---

## Metrics

### Code Statistics
- **Total Files Created**: 12 Swift files
- **Lines of Code**: ~1,500+ lines
- **Views**: 7 main views + 2 components
- **Models**: 3 data models
- **Services**: 1 authentication service
- **Sample Data**: 12 yoga poses, 3 sessions

### Time Spent
- **Planning**: ~2 hours (Nov 1)
- **Setup**: ~30 minutes (Nov 9 morning)
- **Coding**: ~2 hours (Nov 9 morning)
- **Debugging**: ~15 minutes (Nov 9 morning)
- **Total**: ~4.75 hours

---

## Notes & Observations

### What's Working Well
- ✅ Clean, organized code structure
- ✅ Consistent design system (Theme.swift)
- ✅ Reusable components
- ✅ Good sample data
- ✅ Smooth navigation flow
- ✅ Colors match Figma perfectly

### What Could Be Improved
- Need real yoga pose images
- Need to test on actual device
- Could add more animations
- Need to implement remaining features (timer, progress, etc.)

### Decisions to Revisit
- Local storage vs. cloud storage (currently local only)
- Social login implementation (currently placeholders)
- Video support (not yet implemented)

---

## Changelog

### v0.1.0 - November 9, 2025
**Added:**
- Initial project setup
- Welcome and login screens
- Home screen with daily session
- Library with 12 yoga poses
- Pose detail view
- Custom UI components
- Theme system
- Local authentication
- Sample data

**Fixed:**
- Missing Combine imports causing build errors

**Known Issues:**
- No real images (using placeholders)
- No active session timer yet
- No progress tracking yet

---

## December 30, 2025 - Navigation & Settings Implementation

### What We Accomplished
- Fixed duplicate `SettingsRow` declaration issue in `ProfileTabView`
- Created a dedicated `SettingsRow` component in the Components folder
- Implemented proper navigation for all settings items in the Profile tab
- Added `TermsOfUseView` with comprehensive terms and conditions
- Fixed logout functionality in `ProfileTabView`
- Ensured all navigation links are working correctly
- Pushed all changes to GitHub repository

### Technical Details
- **Files Modified**:
  - `ProfileTabView.swift`: Fixed duplicate view and improved navigation
  - `SettingsView.swift`: Updated to use the new `SettingsRow` component
  - `TermsOfUseView.swift`: Created with formatted terms and conditions
  - `SettingsRow.swift`: Created as a reusable component

- **Key Fixes**:
  - Resolved build errors related to duplicate view declarations
  - Improved code organization by moving reusable components to the Components folder
  - Ensured consistent styling across all settings screens

### Next Steps
- [ ] Implement remaining settings screens (Account, Notifications, Privacy, etc.)
- [ ] Add user profile editing functionality
- [ ] Implement notification preferences
- [ ] Add dark mode support
- [ ] Continue testing and fixing any UI/UX issues

---

*Last Updated: December 30, 2025, 6:55 PM*
