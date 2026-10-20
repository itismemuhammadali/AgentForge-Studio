# 🤖 AgentForge Studio

<p align="center">
  <img src="assets/branding/logo.jpg" alt="AgentForge Studio Logo" width="180" style="border-radius: 24px; box-shadow: 0 8px 32px rgba(138, 43, 226, 0.35);" />
</p>

> **Autonomous AI Agent & Custom Bot Orchestration Studio** built with Flutter & Dart, featuring multi-agent workflow management, model training dashboards, real-time telemetry, and third-party API integration pipelines.

[![Flutter](https://img.shields.io/badge/Flutter-3.9+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Backend-Firebase_Suite-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![State](https://img.shields.io/badge/Architecture-Provider_Pattern-blueviolet?style=for-the-badge)](https://pub.dev/packages/provider)
[![Analytics](https://img.shields.io/badge/Telemetry-FL_Chart-00B4D8?style=for-the-badge)](https://pub.dev/packages/fl_chart)

---

## 📌 Executive Summary

**AgentForge Studio** is a multi-platform application designed for enterprise and developer workflows to build, configure, monitor, and deploy conversational and task-oriented AI agents. With an interactive visual dashboard powered by `fl_chart`, users can inspect model training loss curves, active token consumption, and agent invocation analytics in real time.

Built on reactive architecture using Flutter and Provider, AgentForge Studio seamlessly synchronizes bot states across web and mobile surfaces with Cloud Firestore and Firebase Storage.

---

## 🏗️ System Architecture

```mermaid
graph TD
    subgraph Client Application [Flutter Multi-Platform UI]
        AuthView[Authentication & RBAC]
        DashboardView[Visual Telemetry Dashboard - FL Chart]
        BotStudio[Bot Forge & Fine-Tuning Studio]
        IntegrationsHub[External Tool & API Connectors]
        ProfileHub[Developer Credentials & Quotas]
    end

    subgraph State Orchestration [Provider Reactive Layer]
        BotProvider[Bot Lifecycle State Manager]
        AnalyticsProvider[Inference & Telemetry Stream]
        AuthProvider[Session & Token Authenticator]
    end

    subgraph Cloud Infrastructure [Firebase Enterprise Backend]
        AuthService[(Firebase Auth)]
        FirestoreDB[(Cloud Firestore - Agent Definitions & Metrics)]
        CloudStorage[(Firebase Storage - Datasets & Fine-Tune Weights)]
    end

    AuthView --> AuthProvider
    DashboardView --> AnalyticsProvider
    BotStudio --> BotProvider
    IntegrationsHub --> BotProvider

    BotProvider --> FirestoreDB
    BotProvider --> CloudStorage
    AnalyticsProvider --> FirestoreDB
    AuthProvider --> AuthService
```

---

## ✨ Key Capabilities & Features

### 1. 🛠️ Agent Forge & Lifecycle Manager
- **Custom Agent Synthesis:** Define system prompts, temperature parameters, context window limits, and capability flags.
- **Dataset Ingestion:** Interactive file upload pipeline for prompt-response pairs and knowledge base grounding documents.
- **Agent Sandbox:** Live test-run environment to validate prompt behavior before production publishing.

### 2. 📊 Real-Time Telemetry & Visual Analytics
- **Live Loss & Convergence Graphs:** Powered by `fl_chart` with interactive tooltips and crosshairs.
- **Inference Quota Monitoring:** Tracks token throughput, latency percentiles, and active execution budgets.
- **Agent Health Status:** Automated heartbeats and error categorization across distributed endpoints.

### 3. 🔌 Extensible Integrations Hub
- **Webhook & REST Connector Pipeline:** Register external API webhooks for agent tool calling.
- **Secure Key Management:** Client-side obfuscation with encrypted cloud credential persistence.
- **Multi-Tenant Sharing:** Share fine-tuned agents with team workspaces or publish to the internal catalog.

### 4. 🌐 Internationalization & Accessibility
- Native multi-language support configured via `l10n` (`intl` package) for global deployment.
- High-contrast visual tokens and fluid responsive design scaling from mobile to 4K desktop viewports.

---

## 💻 Tech Stack & Dependencies

| Layer | Technologies |
| :--- | :--- |
| **Frontend Framework** | Flutter SDK (Material 3 Adaptive Design) |
| **Language** | Dart 3.x (Sound Null Safety) |
| **State Management** | `provider: ^6.1.0` |
| **Cloud Services** | `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage` |
| **Visual Charts** | `fl_chart: ^0.68.0` |
| **Typography & UI** | `google_fonts: ^6.1.0`, `cupertino_icons: ^1.0.8` |
| **Asset & File System** | `file_picker: ^8.0.0` |
| **Localization** | `flutter_localizations`, `intl: ^0.20.2` |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.9.0`)
- A Firebase project with Firestore and Authentication enabled

### Setup Instructions
```bash
# Clone the repository
git clone https://github.com/itismemuhammadali/AgentForge-Studio.git
cd AgentForge-Studio

# Copy environment template
cp .env.example .env

# Run on your target platform
flutter run -d chrome      # Web
flutter run -d macos       # Desktop macOS
flutter run -d android     # Android Device/Emulator
```

---

## 👤 Author

- **Muhammad Ali**
  - **GitHub:** [@itismemuhammadali](https://github.com/itismemuhammadali)
  - **Portfolio:** [Portfolio Showcase](https://github.com/itismemuhammadali)
