# OAuth Setup Guide - Sign in with Apple & Google

## Overview

OAuth login has been implemented in the code, but requires additional setup to work fully.

### Current Status

✅ **Sign in with Apple**: Implemented and ready (requires Apple Developer account)  
⚠️ **Sign in with Google**: UI ready, requires Google Cloud setup

---

## Sign in with Apple Setup

### Prerequisites
- Apple Developer Account ($99/year)
- App must be published or in TestFlight

### Steps

1. **Enable Sign in with Apple Capability**
   - In Xcode, select your project
   - Go to "Signing & Capabilities"
   - Click "+ Capability"
   - Add "Sign in with Apple"

2. **Configure App ID**
   - Go to https://developer.apple.com/account
   - Navigate to "Certificates, Identifiers & Profiles"
   - Select your App ID
   - Enable "Sign in with Apple"
   - Save

3. **Test**
   - Build and run the app
   - Click the Apple logo button
   - Sign in with your Apple ID
   - App will receive your name and email

### How It Works

When user taps the Apple button:
1. iOS shows Apple Sign In dialog
2. User authenticates with Face ID/Touch ID
3. App receives user's email and name
4. User is automatically signed up/logged in

---

## Sign in with Google Setup

### Prerequisites
- Google Cloud Console account (free)
- OAuth 2.0 Client ID

### Steps

1. **Create Google Cloud Project**
   - Go to https://console.cloud.google.com
   - Create new project: "Unwind Yoga"
   - Enable "Google Sign-In API"

2. **Create OAuth 2.0 Client ID**
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "OAuth 2.0 Client ID"
   - Application type: "iOS"
   - Bundle ID: `com.rahul.UnwindYoga` (your actual bundle ID)
   - Download the configuration file

3. **Add GoogleSignIn SDK**
   - Add to your project via Swift Package Manager:
   ```
   https://github.com/google/GoogleSignIn-iOS
   ```
   - Or use CocoaPods:
   ```ruby
   pod 'GoogleSignIn'
   ```

4. **Configure Info.plist**
   - Add URL scheme:
   ```xml
   <key>CFBundleURLTypes</key>
   <array>
       <dict>
           <key>CFBundleURLSchemes</key>
           <array>
               <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
           </array>
       </dict>
   </array>
   ```

5. **Update OAuthService.swift**
   - Replace the TODO in `signInWithGoogle` with actual Google Sign-In code
   - Example:
   ```swift
   import GoogleSignIn
   
   func signInWithGoogle(completion: @escaping (Result<(email: String, name: String), Error>) -> Void) {
       guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
           return
       }
       
       GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
           if let error = error {
               completion(.failure(error))
               return
           }
           
           guard let user = result?.user,
                 let email = user.profile?.email,
                 let name = user.profile?.name else {
               completion(.failure(OAuthError.failed("Failed to get user data")))
               return
           }
           
           completion(.success((email: email, name: name)))
       }
   }
   ```

6. **Test**
   - Build and run
   - Click Google button
   - Sign in with Google account
   - App receives email and name

---

## Testing Without Full Setup

### Current Behavior

**Apple Sign In**:
- ✅ Will work once you add the capability and have Apple Developer account
- ✅ Code is complete and ready

**Google Sign In**:
- ⚠️ Shows alert: "Google Sign-In requires additional setup"
- ⚠️ User can use email/password instead

### For MVP Testing

You can test the app without OAuth by:
1. Using email/password signup
2. Skipping OAuth buttons for now
3. Setting up OAuth later before App Store submission

---

## Security Notes

### Important

1. **Never hardcode OAuth secrets** in your app
2. **Use secure storage** for tokens (Keychain)
3. **Validate tokens** on your backend (when you add one)
4. **Handle token expiration** and refresh

### Current Implementation

- OAuth tokens are NOT stored (MVP limitation)
- User data is stored in UserDefaults (local only)
- For production: Use Keychain and backend validation

---

## Troubleshooting

### Apple Sign In Issues

**Error: "Sign in with Apple is not available"**
- Solution: Add "Sign in with Apple" capability in Xcode

**Error: "Invalid client"**
- Solution: Ensure App ID is configured correctly in Apple Developer portal

### Google Sign In Issues

**Error: "Google Sign-In requires additional setup"**
- Solution: This is expected! Complete the setup steps above

**Error: "Invalid client ID"**
- Solution: Check that bundle ID matches in Google Cloud Console

---

## Next Steps

### For MVP (Now)
1. ✅ Use email/password authentication
2. ✅ Test forgot password flow
3. ⏳ Set up Apple Sign In (when you have Apple Developer account)
4. ⏳ Skip Google Sign In for now

### For Production (Later)
1. Complete Apple Sign In setup
2. Complete Google Sign In setup
3. Add backend for token validation
4. Implement secure token storage
5. Add social profile picture sync

---

## Files Modified

- `Services/OAuthService.swift` - OAuth logic
- `Views/Onboarding/LoginView.swift` - OAuth UI integration
- `Views/Onboarding/ForgotPasswordView.swift` - Password reset

---

*Last Updated: November 9, 2025*
