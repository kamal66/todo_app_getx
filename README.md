# 📝 To-Do App with Flutter & GetX

A simple yet powerful To-Do application built using **Flutter** and **GetX** for state management. This app demonstrates clean architecture, efficient state management, and modern UI practices in Flutter.

## 🚀 Features

- 📋 **Task Management**: Create, update, delete, and manage your to-dos effortlessly.
- ✅ **Task Completion**: Mark tasks as completed or pending.
- 🌓 **Dark Mode**: Toggle between light and dark themes for better usability.
- 📂 **Persistent Storage**: Save tasks locally using GetStorage.
- 📊 **Task Reports**: Visualize your progress with task completion statistics and charts.
- 🎨 **Amazing UI Features**:
    - **Smooth Animations**: Enjoy seamless transitions and animations for a delightful user experience.
    - **Responsive Design**: Perfectly optimized for various screen sizes and orientations.
    - **Custom Themes**: Switch between elegant light and dark themes with a single tap.
    - **Interactive Elements**: Intuitive gesture controls like swiping to delete tasks.


## 📱 Screenshots

| Light Theme                                                                                                                                                     | Dark Theme                                                                                                                                                     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/kamal66/todo_app_getx/blob/main/screenshots/light_ss.gif?raw=true" width="250" height="auto" alt="Screenshot 1"/> | <img src="https://github.com/kamal66/flutter_live_location_tracking/blob/main/screenshots/dark_ss.png?raw=true" width="250" height="auto" alt="Screenshot 2"/> |


## 🛠️ Technologies Used

- **Flutter**: The UI toolkit for building natively compiled applications.
- **GetX**: State management, navigation, and dependency injection.
- **GetStorage**: Lightweight and efficient local storage solution.


## 📂 Project Structure

```plaintext
lib/
├── app
|    ├── controller
|    |   └─── theme_controller.dart
|    ├── core
|    |   ├── utils
|    |   |   ├── extensions.dart
|    |   |   └── keys.dart
|    |   └─── values
|    |        ├── colors.dart
|    |        └── icons.dart
|    ├── data
|    |   ├── models
|    |   |   └─── task.dart
|    |   ├── providers
|    |   |   └───task
|    |   |       └── provider.dart
|    |   └───services
|    |       └───storage
|    |           ├── repository.dart
|    |           └── services.dart
|    ├── modules
|    |   ├── details
|    |   |   ├── details_page.dart
|    |   |   |
|    |   |   └── widgets
|    |   |       ├── doing_list.dart
|    |   |       └── done_list.dart
|    |   ├── home
|    |   |   ├── binding.dart
|    |   |   ├── controller.dart
|    |   |   ├── home_page.dart
|    |   |   └── widgets
|    |   |       ├── add_card.dart
|    |   |       ├── add_dialog.dart
|    |   |       └── task_card.dart
|    |   └── report
|    |       └── report_page.dart
|    ├── utils
|    |   ├── constants.dart
|    |   └───theme
|    |       ├── theme.dart
|    |       └── custom_themes
|    |           ├── appbar_theme.dart
|    |           └── text_theme.dart
|    └───widgets
|        └── icons.dart
└─── main.dart  
```

### Key Folders:
- **controllers/**: Contains the logic for managing state and business logic using GetX.
- **models/**: Defines data structures for tasks.
- **views/**: Handles the UI of the application.
- **widgets/**: Reusable UI components.
- **utils/**: Theming and utility functions.

---

## 🧰 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/todo-app-getx.git
   cd todo-app-getx
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---   

### ✨ How to Use
1. **Add Tasks**: Click the "+" button to add a new task.
2. **Edit Tasks**: Tap on a task to update its details.
3. **Delete Tasks**: Swipe left or right on a task to delete it.
4. **View Reports**: Access the Task Report section to see your task completion stats.
5. **Switch Themes**: Toggle between light and dark themes using the settings.

---

### 📄 License
This project is licensed under the **Apache License**. See the [LICENSE](LICENSE.txt) file for details.

---

### 🙌 Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

---

### 🐛 Issues
If you encounter any issues, feel free to report them [here](https://github.com/kamal66/todo_app_getx/issues).