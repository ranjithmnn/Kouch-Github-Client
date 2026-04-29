# Kouch — Native GitHub Client

![Swift](https://img.shields.io/badge/Swift-F05138?style=flat&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-007AFF?style=flat&logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-17.0%2B-black?style=flat&logo=apple&logoColor=white)

**Kouch** is a premium, native iOS application built using SwiftUI. It provides a seamless and elegant way to interact with your GitHub activities, allowing you to manage repositories, track issues, and stay updated with your development workflow directly from your iPhone.

---

## ✨ Features

- **📊 Dashboard:** A centralized overview of your GitHub activity and metrics.
- **📁 Repositories:** Browse, search, and explore your public and private repositories.
- **🐛 Issue Tracking:** Stay on top of your tasks with a dedicated issues viewer and comment manager.
- **👤 Profile:** View detailed user information and contributions.
- **🧩 Widgets:** Native iOS Home Screen widgets to keep track of your active issues at a glance.

---

## 🛠️ Technology Stack

- **UI Framework:** SwiftUI for a truly native look and feel.
- **Architecture:** Clean, modular architecture for scalability and maintainability.
- **Concurrency:** Leverages modern Swift `async/await` for high-performance networking.
- **Networking:** Direct integration with [GitHub REST API v3](https://docs.github.com/en/rest).
- **Persistence:** Efficient data handling for a responsive user experience.

---

## 🚀 Getting Started

### Prerequisites

- **Xcode 15.0** or later.
- **iOS 26.0** or later.
- A **GitHub Personal Access Token**.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ranjithmnn/Kouch-Github-Client.git
   cd Kouch-Github-Client
   ```

2. **Configure your API Key:**
   The app requires a GitHub Personal Access Token to authenticate. 
   - Open the project in Xcode.
   - Add your token to `Info.plist` under the key `GITHUB_API_KEY` (or configure it via a `.xcconfig` file as expected by the project).

3. **Build and Run:**
   - Select the **Kouch** scheme.
   - Choose a simulator or your connected iOS device.
   - Press `Cmd + R` to build and run.

---

## 🏗️ Project Structure

```text
Kouch/
├── App/            # App Entry point and Lifecycle
├── Core/           # Networking, Models, and Services
├── Features/       # Feature-specific Views and Logic (Dashboard, Issues, etc.)
├── SharedUI/       # Reusable UI components and Design System
└── Assets/         # Images, Colors, and Icons
```

---

## 🤝 Contributing

Contributions are welcome! If you have suggestions for improvements or want to report a bug, please open an issue or submit a pull request.

---

*Developed with ❤️ by [Ranjith Menon](https://github.com/ranjithmnn)*
