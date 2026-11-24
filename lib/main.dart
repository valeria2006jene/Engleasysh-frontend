import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'dictionary_screen.dart';
import 'onboarding_screen.dart';

const Color bgColor = Color(0xFFDEE6F2);
const Color fontColor = Color(0xFF2D4B63);
const Color lightTextColor = Color(0xFF6D88A5);

// ГЛОБАЛЬНІ ЗМІННІ КОРИСТУВАЧА

String globalUserName = "Luicha";
String globalUserAvatar =
    "https://cdn-icons-png.flaticon.com/512/10434/10434315.png";
String globalUserStatus = "Вивчаю англійську 🐣";
String globalUserPhone = "+380";
String globalUserEmail = "user@email.com";

// ГЛОБАЛЬНІ ЗМІННІ ДЛЯ НАЛАШТУВАНЬ

String globalSelectedVoice = 'Американський акцент (Жіночий)';
int globalSelectedAiAvatar = 0;
bool globalFocusMode = false;
bool globalNotifLessons = true;
bool globalNotifAchievements = true;
bool globalNotifDaily = false;
bool globalDarkModeEnabled = false;

// ======================================================
// ЗАПУСК ЗАСТОСУНКУ
// ======================================================

void main() {
  runApp(const EnglysyshApp());
}

class EnglysyshApp extends StatelessWidget {
  const EnglysyshApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Englysysh",

      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        fontFamily: "Inter",
      ),

      home: const OnboardingScreen(),
    );
  }
}

// ======================================================
// ГОЛОВНА НАВІГАЦІЯ
// ======================================================

class MainNavigator extends StatefulWidget {
  final int initialIndex;

  const MainNavigator({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  // ПЕРЕМИКАННЯ ЕКРАНІВ

  void changeScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // ЕЛЕМЕНТИ НИЖНЬОЇ НАВІГАЦІЇ

  Widget navItem(String asset, int index) {
    final active = selectedIndex == index;

    return GestureDetector(
      onTap: () => changeScreen(index),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        transform: Matrix4.translationValues(
          0,
          active ? -8 : 0,
          0,
        ),

        child: Image.asset(
          asset,
          width: 32,
          height: 32,
        ),
      ),
    );
  }

  // ======================================================
  // ПОБУДОВА ЕКРАНІВ
  // ======================================================

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        key: const ValueKey("home"),
        userName: globalUserName,
        avatarUrl: globalUserAvatar,
      ),

      HistoryScreen(
        key: const ValueKey("history"),
        userName: globalUserName,
        avatarUrl: globalUserAvatar,
      ),

      DictionaryScreen(
        key: const ValueKey("dictionary"),
        userName: globalUserName,
        avatarUrl: globalUserAvatar,
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,

      // INDEXED STACK ЗБЕРІГАЄ СТАН УСІХ ЕКРАНІВ

      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      // ==================================================
      // НИЖНЯ НАВІГАЦІЯ
      // ==================================================

      bottomNavigationBar: SizedBox(
        height: 90,

        child: Container(
          color: bgColor,

          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 18,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              navItem("assets/home.png", 0),

              const SizedBox(width: 56),

              navItem("assets/chat.png", 1),

              const SizedBox(width: 56),

              navItem("assets/book.png", 2),
            ],
          ),
        ),
      ),
    );
  }
}