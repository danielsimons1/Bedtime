# Bedtime - Stories for your child

An iOS app for creating magical bedtime stories for children.

## Features

- **Splash Screen**: Beautiful shooting star animation on launch
- **Landing Page**: Welcome screen with "Bedtime: Stories for your child" branding
- **Onboarding Flow**: Collects child's name and gender preferences
- **Paywall**: Two subscription options:
  - Monthly: $9.99/month
  - Annual: $39.99/year (Save 67%)
- **Premium Features**:
  - Enjoy access to all stories
  - Pick from valuable lessons
  - Create your own personalized story

## Project Structure

```
Bedtime/
├── Bedtime/
│   ├── BedtimeApp.swift          # Main app entry point
│   ├── ContentView.swift         # Root content view with navigation
│   ├── Models/
│   │   └── AppState.swift        # App state management
│   └── Views/
│       ├── SplashScreen.swift    # Shooting star animation screen
│       ├── LandingView.swift     # Main landing page
│       ├── OnboardingView.swift  # Child name & gender collection
│       ├── PaywallView.swift     # Subscription paywall
│       └── MainView.swift        # Main app screen (post-paywall)
└── Bedtime.xcodeproj/
```

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/danielsimons1/Bedtime.git
   cd Bedtime
   ```

2. Open the project in Xcode:
   ```bash
   open Bedtime.xcodeproj
   ```

3. Build and run the app on a simulator or device

## Architecture

The app uses SwiftUI with a centralized state management approach:

- **AppState**: ObservableObject that manages the current screen and user data
- **Screen Navigation**: Enum-based screen system for clean navigation flow
- **View Structure**: Each screen is a separate view component

## Next Steps

- [ ] Implement actual StoreKit integration for subscriptions
- [ ] Add story content and story generation
- [ ] Implement user authentication
- [ ] Add analytics and crash reporting
- [ ] Create app icon and additional assets
- [ ] Add sound effects and background music
- [ ] Implement data persistence

## License

Copyright © 2026 Bedtime. All rights reserved.
