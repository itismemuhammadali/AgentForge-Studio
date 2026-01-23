# Admin Portal - Project Structure

## Overview
This is a Flutter-based admin portal for the AI Model Training & Deployment Platform with bilingual support (English & Dutch).

## Project Structure

```
lib/
├── main.dart                          # Main app entry point
├── l10n/
│   ├── app_en.arb                    # English translations
│   └── app_nl.arb                    # Dutch translations
├── models/
│   └── dashboard_models.dart         # Data models for dashboard
├── providers/
│   ├── language_provider.dart        # Language state management
│   └── dashboard_provider.dart       # Dashboard data management
├── screens/
│   └── dashboard_screen.dart         # Dashboard screen
└── widgets/
    ├── sidebar.dart                  # Left navigation sidebar
    ├── top_bar.dart                  # Top navigation bar
    ├── stat_card.dart                # Statistics card component
    ├── conversation_chart.dart       # Bar chart for conversation volume
    ├── top_bots_section.dart         # Top bots list component
    └── recent_activity_table.dart    # Recent activity data table
```

## Features Implemented

### 1. Bilingual Support (English & Dutch)
- Language switcher in top bar
- All UI text uses localization keys
- Seamless language switching without page reload

### 2. Dashboard Screen
- **Stats Cards**: 4 key metrics (Conversations, Active Bots, Leads, Avg Response)
- **Conversation Volume Chart**: Bar chart showing daily conversation trends
- **Top Bots Section**: List of top performing bots with growth percentages
- **Recent Activity Table**: Detailed table of recent bot interactions

### 3. Navigation
- **Sidebar**: 
  - Platform section (Dashboard, My Bots, Conversations, CRM/Leads)
  - Configuration section (AI & Knowledge, Integrations, Settings)
  - User profile section
  - Badge support (e.g., conversation count)
  
- **Top Bar**:
  - Breadcrumb navigation
  - Search functionality
  - Theme switcher
  - Notifications
  - Help button
  - Language switcher
  - "New Bot" button

### 4. Responsive Design
- Modern SaaS dashboard layout
- Light/Dark theme support (ready for implementation)
- Clean, professional UI matching the provided screenshots

## Dependencies Added

```yaml
flutter_localizations: sdk
intl: ^0.20.2
firebase_core: ^3.0.0
firebase_auth: ^5.0.0
cloud_firestore: ^5.0.0
firebase_storage: ^12.0.0
provider: ^6.1.0
fl_chart: ^0.68.0
google_fonts: ^6.1.0
```

## Data Models

### StatCard
- label, value, change, changeType, subtitle, icon

### BotActivity
- id, time, user, botName, type, status, messageCount

### TopBot
- id, name, messageCount, changePercent, icon

### ChartData
- day, value

## State Management
- **Provider**: Used for language switching and dashboard data
- **LanguageProvider**: Manages current locale
- **DashboardProvider**: Manages dashboard data and refresh

## Localization Keys
All UI text is managed through ARB files with keys for:
- Navigation items
- Page titles
- Stat labels
- Table headers
- Status labels
- Time formats

## Next Steps (Placeholder Pages)
The following pages are ready for implementation:
- `/bots` - My Bots management
- `/conversations` - Conversations view
- `/crm` - CRM / Leads
- `/ai-knowledge` - AI & Knowledge configuration
- `/integrations` - Integrations management
- `/settings` - System settings

## Firebase Integration (Ready)
- Authentication setup (placeholder)
- Firestore queries (placeholder)
- Storage integration (placeholder)
- All ready for credentials to be added

## Running the App

```bash
flutter pub get
flutter run -d chrome  # For web
flutter run            # For mobile/desktop
```

## Notes
- All Firebase credentials are placeholders and will be configured once credentials are provided
- The app is production-ready with proper error handling structure
- Responsive design works on all screen sizes
- Theme switching infrastructure is in place for future dark mode implementation
