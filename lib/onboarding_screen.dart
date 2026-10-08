import 'package:flutter/material.dart';
import 'main.dart'; 
import 'registration_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Головний екран",
      "description": "Слідкуйте за своїм прогресом, отримуйте відзнаки за регулярність та переглядайте щоденну статистику.",
      "image": "assets/screen_home.png",
    },
    {
      "title": "Статистика та досягнення",
      "description": "Ведіть живі розмови. ШІ оцінить вашу вимову та граматику за стандартами Cambridge.",
      "image": "assets/screen_stats.png",
    },
    {
      "title": "Ваш Словник",
      "description": "Тут автоматично зберігаються всі нові слова з розмов. Повторюйте їх та розширюйте лексикон.",
      "image": "assets/screen_dict.png",
    },
    {
      "title": "Налаштування",
      "description": "Тисніть на ⚙️ на будь-якому екрані, щоб змінити аватар репетитора, налаштувати голос або увімкнути фокус.",
      "image": "assets/screen_settings.png",
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _onboardingData.length - 1;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Фонові елементи
          Positioned(
            top: -80,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.4)),
            ),
          ),
          Positioned(
            top: 250,
            left: -80,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(shape: BoxShape.circle, color: fontColor.withValues(alpha: 0.03)),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Кнопка "Пропустити"
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 8),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isLastPage ? 0.0 : 1.0,
                      child: TextButton(
                        onPressed: isLastPage ? null : _finishOnboarding,
                        child: const Text("Пропустити", style: TextStyle(color: lightTextColor, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),

                // Свайпер екранів
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      final data = _onboardingData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // // Мокап смартфона зі скріншотом
Expanded(
  child: Center(
    child: Container(
      // ЗБІЛЬШЕНІ РОЗМІРИ: тепер скріншот буде значно ширшим та вищим
      constraints: const BoxConstraints(maxHeight: 520, maxWidth: 250),
      decoration: BoxDecoration(
        color: Colors.transparent, 
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: fontColor.withValues(alpha: 0.15), 
            blurRadius: 25, 
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          data["image"]!,
          fit: BoxFit.contain, 
        ),
      ),
    ),
  ),
),
const SizedBox(height: 20), 
                            

                            // Картка з текстом
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 10))],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    data["title"]!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: fontColor, height: 1.2),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    data["description"]!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14, color: lightTextColor, height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Нижня панель управління
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Індикатор
                      Row(
                        children: List.generate(
                          _onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 6),
                            height: 8,
                            width: _currentPage == index ? 28 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index ? fontColor : fontColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      // Анімована кнопка
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: isLastPage ? 160 : 70,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: fontColor,
                            elevation: 5,
                            shadowColor: fontColor.withValues(alpha: 0.5),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: _nextPage,
                          child: isLastPage
                              ? const Text("Почати", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
                              : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}