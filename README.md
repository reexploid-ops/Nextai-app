# Next AI — Flutter Starter

[![Build Android APK](https://github.com/USERNAME/REPO/actions/workflows/build-apk.yml/badge.svg)](../../actions)

A premium dark-mode AI assistant app starter project built with Flutter.

> 📱 **Want to build APK without installing anything?** Read **[PANDUAN_BUILD_APK.md](PANDUAN_BUILD_APK.md)** — push code, get APK in ~8 minutes via GitHub Actions (free).

---

## ✨ Features Included

- 🎨 **Premium dark theme** with purple-pink gradient accent system
- 🤖 **Multi-model chat screen** with switchable AI models (GPT-4o, Claude 3.5, Gemini 2.0, DeepSeek-R1)
- 🎙 **Voice Mode screen** with animated pulsing orb (live transcription mock)
- 📂 **Projects & Memory screen** with horizontal project cards + memory chips
- 🧭 **Bottom navigation** (Chat / Voice / Projects)
- 📦 **Provider state management** ready for API integration
- 🤖 **GitHub Actions CI/CD** for automatic APK builds

## 🚀 Quick Start

### Option 1: Build APK in the Cloud (No Local Install Needed) ⭐

1. Fork/create this repo on GitHub
2. Push code → workflow auto-builds APK
3. Download from Actions tab → Artifacts

👉 **Detailed guide:** [PANDUAN_BUILD_APK.md](PANDUAN_BUILD_APK.md)

### Option 2: Build Locally

Prerequisites: Flutter SDK ≥ 3.10.0, JDK 17, Android SDK

```bash
flutter pub get
flutter create --platforms=android --project-name nextai --org com.nextai .
flutter build apk --debug
# APK at: build/app/outputs/flutter-apk/app-debug.apk
```

## 📁 Project Structure

```
nextai_flutter/
├── .github/workflows/
│   ├── build-apk.yml         # Auto-build on every push
│   └── release.yml           # Auto-release on git tag
├── lib/
│   ├── main.dart             # App entrypoint
│   ├── theme/app_theme.dart  # Colors + gradient system
│   ├── models/               # Data models
│   ├── services/             # State management (Provider)
│   ├── screens/              # Chat, Voice, Projects screens
│   └── widgets/              # Reusable UI components
├── pubspec.yaml              # Dependencies
├── README.md
└── PANDUAN_BUILD_APK.md      # Detailed APK build guide (Bahasa Indonesia)
```

## 🎨 Design System

| Token | Value |
|---|---|
| Background | `#0A0B14` |
| Surface | `#0F1117` |
| Surface Elevated | `#1F2230` |
| Accent Purple | `#8B5CF6` |
| Accent Pink | `#EC4899` |
| Text Primary | `#FFFFFF` |
| Text Secondary | `#9CA3AF` |
| Font | Inter (via google_fonts) |

## 🔌 Connect to a Real AI API

Replace the mock response in `lib/services/chat_state.dart` `sendMessage()`:

```dart
final response = await http.post(
  Uri.parse('https://api.openai.com/v1/chat/completions'),
  headers: {
    'Authorization': 'Bearer YOUR_API_KEY',
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'model': _selectedModel.toLowerCase(),
    'messages': _messages.map((m) => {
      'role': m.role.name,
      'content': m.content,
    }).toList(),
  }),
);
```

## 📝 Roadmap

- [ ] Real OpenAI / Anthropic / Gemini API integration
- [ ] Image generation screen (DALL·E / Flux)
- [ ] Camera / vision screen
- [ ] Onboarding flow (3 screens)
- [ ] Paywall / In-App Purchase
- [ ] Persistent storage (SharedPreferences / sqflite)
- [ ] Localization (i18n) for Bahasa Indonesia & English

## 📄 License

Use freely for your own AI app project.
