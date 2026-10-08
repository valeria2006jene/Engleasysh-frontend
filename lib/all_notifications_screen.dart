import 'package:flutter/material.dart';
import 'widgets.dart';
import 'main.dart' show MainNavigator; // Уникаємо конфлікту кольорів

class AllNotificationsScreen extends StatelessWidget {
  const AllNotificationsScreen({super.key});

  Widget _buildStaticNavItem(BuildContext context, String asset, int targetIndex) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => 
                MainNavigator(initialIndex: targetIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Плавний перехід (Fade) без зсуву в бік
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
          (route) => false,
        );
      },
      child: Image.asset(
        asset,
        width: 32,
        height: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"isHeader": true, "text": "Нещодавні"},
      {"isHeader": false, "emoji": "🐣", "text": "Я сьогодні навчився новому слову. А ти?", "time": "35 min"},
      {"isHeader": true, "text": "Раніше"},
      {"isHeader": false, "emoji": "🌃", "text": "Розкажи як сьогодні пройшов твій день?", "time": "5h"},
      {"isHeader": false, "emoji": "🐭", "text": "Твоя пацюня засумувала, підбадьорь її мерщій!", "time": "2d"},
      {"isHeader": true, "text": "За часів царя гороха..."},
      {"isHeader": false, "emoji": "🌃", "text": "Розкажи як сьогодні пройшов твій день?", "time": "1w"},
      {"isHeader": false, "emoji": "🌙", "text": "Давно тебе не було. Повернися до навчання!", "time": "5w"},
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "All notifications",
          style: TextStyle(
            color: fontColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/arrow.png',
            width: 24,
            height: 24,
            color: fontColor,
            errorBuilder: (c, e, s) => const Icon(Icons.arrow_back_ios_new, color: fontColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            if (item["isHeader"] == true) {
              return Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8, right: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item["text"],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["emoji"],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        item["text"],
                        style: const TextStyle(
                          fontSize: 14,
                          color: fontColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item["time"],
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Container(
          color: bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStaticNavItem(context, "assets/home.png", 0),
              const SizedBox(width: 56),
              _buildStaticNavItem(context, "assets/chat.png", 1),
              const SizedBox(width: 56),
              _buildStaticNavItem(context, "assets/book.png", 2),
            ],
          ),
        ),
      ),
    );
  }
}