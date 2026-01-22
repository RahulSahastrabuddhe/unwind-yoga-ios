# Changelog

All notable changes to the Unwind Yoga iOS app will be documented in this file.

## [1.1.1] - 2026-01-21

### Added
- Dynamic progress tracking with real-time statistics
- Automatic daily activity tracking when app opens
- Session completion tracking with duration calculation
- Interactive progress calendar with completed days visualization
- ProgressService for managing user progress data
- Weekly goal progress visualization with animated circle
- Real-time streak calculation and session counting
- Persistent progress storage with UserDefaults

### Changed
- Profile statistics now show actual user data instead of static values
- Progress tab uses real completed sessions instead of sample data
- Enhanced Apple Sign-In with proper presentation context
- Improved error handling for all authentication scenarios
- Added loading states for Apple Sign-In button
- Updated tech stack to include ProgressService

### Fixed
- Apple Sign-In presentation context for iPad compatibility
- Memory management issues with [weak self] references
- Authentication error handling with specific error codes
- Static profile data showing incorrect initial values
- Progress calendar not reflecting real user activity

### Technical
- Added progress tracking properties to User model
- Implemented proper window presentation for Apple Sign-In
- Enhanced OAuthService with better error handling
- Created comprehensive progress tracking system
- Improved session duration tracking and logging

### Milestone
- **🎉 READY FOR APP STORE RESUBMISSION** - Apple Sign-In fixed, progress tracking implemented

## [1.1.0] - 2026-01-18

### Added
- Video playback support for yoga poses
- Full-screen video player with play/pause controls
- Video indicators in the pose library
- Daily session with 5 random poses
- Enhanced error handling and debugging
- Detailed logging for video loading issues
- App Store screenshots and metadata
- Privacy policy URL for App Store compliance
- TestFlight internal testing setup

### Changed
- Updated YogaPose model to include video names
- Improved video loading reliability
- Enhanced UI for video player controls
- Updated README with latest features and setup instructions
- Fixed app icon transparency issues for App Store submission
- Resolved Xcode signing and provisioning profile issues

### Fixed
- Video file loading issues
- Memory management for video playback
- Navigation issues in the daily session flow
- App Store submission requirements (app icon, privacy policy)
- Xcode signing errors and provisioning profile setup

### Milestone
- **🎉 SUBMITTED TO APP STORE FOR REVIEW** - January 18, 2026

## [1.0.0] - 2025-12-20

### Added
- Initial release of Unwind Yoga
- User authentication with local storage
- Home screen with daily recommendations
- Pose library with search and filter
- Detailed pose information and benefits
- Custom UI components and theming
