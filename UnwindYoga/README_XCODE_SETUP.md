# Xcode Project Setup Instructions

## Files Created

I've created all the necessary Swift files for your Unwind Yoga app. Now you need to add them to your Xcode project.

## How to Add Files to Xcode

### Step 1: Open Your Project
1. Open Xcode
2. Open your `UnwindYoga.xcodeproj` file

### Step 2: Add All New Files

You need to add these folders and files to your Xcode project:

**In the Project Navigator (left sidebar), right-click on "UnwindYoga" folder and select "Add Files to UnwindYoga..."**

Then add these folders one by one:
1. `Models/` folder (contains YogaPose.swift, YogaSession.swift, User.swift)
2. `Views/` folder (contains all view files)
3. `Utilities/` folder (contains Theme.swift)
4. `Services/` folder (contains AuthService.swift)

**Important**: When adding files, make sure:
- ✅ "Copy items if needed" is UNCHECKED (files are already in the right place)
- ✅ "Create groups" is selected
- ✅ "UnwindYoga" target is checked

### Alternative: Drag and Drop Method

1. In Finder, navigate to: `/Users/rahulsahastrabuddhe/Documents/11:25/Unwind Yoga/UnwindYoga/UnwindYoga/`
2. You'll see these folders:
   - Models
   - Views
   - Utilities
   - Services
3. Drag each folder into Xcode's Project Navigator (left sidebar)
4. Drop them onto the "UnwindYoga" folder (the yellow folder icon)
5. In the dialog that appears:
   - ✅ UNCHECK "Copy items if needed"
   - ✅ SELECT "Create groups"
   - ✅ CHECK "UnwindYoga" target
   - Click "Finish"

## Step 3: Verify Files Are Added

In Xcode's Project Navigator, you should now see this structure:

```
UnwindYoga/
├── UnwindYogaApp.swift (modified)
├── ContentView.swift (original, can delete)
├── Models/
│   ├── YogaPose.swift
│   ├── YogaSession.swift
│   └── User.swift
├── Views/
│   ├── Onboarding/
│   │   ├── WelcomeView.swift
│   │   └── LoginView.swift
│   ├── Home/
│   │   └── HomeView.swift
│   ├── Library/
│   │   ├── LibraryView.swift
│   │   └── PoseDetailView.swift
│   └── Components/
│       ├── CustomButton.swift
│       └── CustomTextField.swift
├── Services/
│   └── AuthService.swift
├── Utilities/
│   └── Theme.swift
└── Assets.xcassets
```

## Step 4: Build and Run

1. Select a simulator (e.g., iPhone 15 Pro) from the top toolbar
2. Click the Play button (▶️) or press `Cmd + R`
3. Wait for the app to build and launch

## What You Should See

1. **Welcome Screen** with:
   - Yoga icon
   - "Welcome to Unwind Yoga" text
   - Continue button
   - Terms and Privacy links

2. After clicking Continue:
   - **Login/Signup Screen** with email and password fields

3. After signing up/logging in:
   - **Home Screen** with daily session card and greeting

4. Click "Browse More Poses":
   - **Library Screen** with list of yoga poses

5. Click any pose:
   - **Pose Detail Screen** with description and benefits

## Troubleshooting

### If you see build errors:

1. **"Cannot find type 'Theme' in scope"**
   - Make sure Theme.swift is added to the project
   - Clean build folder: Product → Clean Build Folder (Cmd + Shift + K)

2. **"No such module 'SwiftUI'"**
   - Make sure your deployment target is iOS 17.0 or later
   - Check in Project Settings → General → Deployment Info

3. **Files appear red in Xcode**
   - The files aren't properly added
   - Try removing them and adding again using the steps above

4. **App crashes on launch**
   - Check the console for error messages
   - Make sure all files are added to the UnwindYoga target

### If the app builds but shows a blank screen:

1. Check that UnwindYogaApp.swift was properly updated
2. Try: Product → Clean Build Folder, then rebuild

## Next Steps

Once the app is running successfully:

1. ✅ Test the welcome screen
2. ✅ Test sign up flow
3. ✅ Test login flow
4. ✅ Navigate through home screen
5. ✅ Browse the library
6. ✅ View pose details

Let me know if you encounter any issues!

## Features Implemented (v1.0)

- ✅ Welcome/Onboarding screen
- ✅ Login/Signup (local storage)
- ✅ Home screen with daily session
- ✅ Library with 12 sample yoga poses
- ✅ Pose detail view with descriptions and benefits
- ✅ Search and filter functionality
- ✅ Custom theme with your brand colors
- ✅ Responsive UI matching Figma design

## What's NOT in v1.0 (Future Updates)

- ❌ Active session with timer
- ❌ Progress tracking
- ❌ Profile screen
- ❌ Notifications
- ❌ Backend integration
- ❌ Social login (Apple, Google)
- ❌ Actual pose images (using placeholders)
