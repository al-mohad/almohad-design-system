# Almohad Design System

This Design System is a collection of reusable UI components for Flutter applications, including buttons, cards, chat bubbles, and more.

## Features

- **Reusable Components**: Pre-built widgets for buttons, cards, chat bubbles, and more.
- **Customizable**: Easily modify styles and layouts to match your design needs.
- **Lightweight**: Designed for efficiency with minimal dependencies.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_design_system: latest_version
```

## 🎨 UI Components

### 🔘 Buttons

```dart
  DesignSystem.button(
  text: "Primary Button",
  onPressed: () {
    debugPrint("Primary Button Clicked");
  },
  type: ButtonType.primary,
  textColor: Colors.white,
  animationType: ButtonAnimationType.slide,
),

DesignSystem.button(
  text: "Secondary Button",
  onPressed: () {
    debugPrint("Secondary Button Clicked");
  },
  type: ButtonType.secondary,
  textColor: Colors.black,
  borderColor: Colors.black,
),

DesignSystem.button(
  text: "Icon Start",
  onPressed: () {
    debugPrint("Button with Icon Clicked");
  },
  type: ButtonType.primary,
  textColor: Colors.white,
  buttonColor: Colors.green,
  icon: const Icon(Icons.thumb_up, color: Colors.white),
  iconAffinity: IconAffinity.start,
),

DesignSystem.button(
  text: "Icon End",
  onPressed: () {
    debugPrint("Button with Icon End Clicked");
  },
  type: ButtonType.primary,
  textColor: Colors.white,
  buttonColor: Colors.orange,
  icon: const Icon(Icons.arrow_forward, color: Colors.white),
  iconAffinity: IconAffinity.end,
),

DesignSystem.button(
  text: "Square Button",
  onPressed: () {
    debugPrint("Square Button Clicked");
  },
  type: ButtonType.primary,
  buttonColor: Colors.red,
  textColor: Colors.white,
  radius: 0,
),

DesignSystem.button(
  text: "Small Button",
  onPressed: () {
    debugPrint("Small Button Clicked");
  },
  type: ButtonType.primary,
  textColor: Colors.white,
  height: 35,
  width: 120,
  fontSize: 12,
),

DesignSystem.button(
  text: "Large Button",
  onPressed: () {
    debugPrint("Large Button Clicked");
  },
  type: ButtonType.primary,
  textColor: Colors.white,
  height: 60,
  width: 250,
  fontSize: 20,
  fontWeight: FontWeight.bold,
),

DesignSystem.button(
  text: "Custom Colored",
  onPressed: () {
    debugPrint("Custom Colored Button Clicked");
  },
  type: ButtonType.primary,
  buttonColor: Colors.purple,
  textColor: Colors.white,
  borderColor: Colors.yellow,
),

DesignSystem.button(
  text: "Rounded Button",
  onPressed: () {
    debugPrint("Rounded Button Clicked");
  },
  type: ButtonType.primary,
  textColor: Colors.white,
  radius: 50,
),
```

### 🔘 Chats

#### Bubble

```dart
DesignSystem.chatBubble(
  message: ChatMessage(
    text: "Hello, how are you?",
    time: DateTime.now(),
  ),
  isSender: true,
);
```

#### 🔘 Audio Player

```dart
DesignSystem.audioPlayer(
  isSender: false,
  audioUrl:
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  audioTitle: 'The SoundHelix Song',
  showUserAvatar: true,
  userAvatar: "i.pravatar.cc",
  backgroundColor: Colors.blue,
  doneColor: Colors.green,
  time: DateTime.now(),
  status: ChatStatus.read,
);
```

### 🔘 TextFormFields

```dart
DesignSystem.textField(
  label: "Username",
  hintText: "Enter your username",
);
```

### 🔘 Containers

```dart
DesignSystem.container(
  color: Colors.blueAccent,
  borderRadius: 10,
  padding: const EdgeInsets.all(16),
  child: Text("Hello Container!"),
);
```

### 🔘 Images

#### Parallax Image View

```dart
DesignSystem.parallaxImage(
  imageUrl: "https://www.example.com/image.jpg",
  height: 200,
  parallaxFactor: 0.3,
);
```

#### Icon Image

```dart
DesignSystem.iconImage(
  assetPath: "https://www.example.com/image.jpg",
  size: 34,
  color: Colors.transparent
  isSvg: true,
);
```

### 🔘 LiveTime

```dart
DesignSystem.liveTime(
  child: Text("Live Date & Time"),
);
```

### 🔘 Glassmorphism

```dart
DesignSystem.glass(
  child: Text("Glass Effect"),
);
```

### 🔘 Neumorphism

```dart
DesignSystem.neu(
  child: Icon(Icons.star, size: 40),
);
```

### 🔘 Expansions

```dart
DesignSystem.expandedContent(
  expandedChildren: [
    Text("Expanded Content 1"),
    Text("Expanded Content 2"),
  ],
  collapsedContent: Text("Drag up to Expand"),
);
```

### ✅ **What's Improved?**

- **Structured Markdown format** 📑.
- **Code blocks for each widget** 🏗️.
- **Clear section headers for better readability** 🎯.

Let me know if you need further refinements! 🚀

## 🔙 Handling Android Back Navigation (Android 13+)

Starting from **Android 13 (API 33)**, Android requires apps to register **OnBackInvokedCallback** for back gesture support.

To enable this in your Flutter app, make sure you are using **Flutter 3.7+** (or later).

### ✅ **Solution**

Add this inside your `AndroidManifest.xml`:

```xml
<manifest>
    <application
        android:enableOnBackInvokedCallback="true"
        ... >
    </application>
</manifest>
```
