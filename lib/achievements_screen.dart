import 'package:flutter/material.dart';
import 'widgets.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> achievements = [
      {"title": "В ударі", "progress": "6/7", "icon": "assets/vydari.png", "condition": "Тримайте активність 7 днів поспіль."},
      {"title": "Словопліт", "progress": "21/35", "icon": "assets/slovoplit.png", "condition": "Використайте 35 нових слів у розмовах."},
      {"title": "Рання пташка", "progress": "2/5", "icon": "assets/rannyaptashka.png", "condition": "Провести 5 ранкових занять (до 09:00)."},
      {"title": "Балакун", "progress": "20/20", "icon": "assets/balakyn.png", "condition": "Проведіть 20 діалогів з ШІ-репетитором."},
      {"title": "Оратор", "progress": "14/25", "icon": "assets/orator.png", "condition": "Наговоріть 25 хвилин без пауз та запинання."},
      {"title": "Нічна сова", "progress": "5/5", "icon": "assets/nichnasova.png", "condition": "Провести 5 нічних занять (після 20:00)."},
      {"title": "Слухач", "progress": "5/10", "icon": "assets/sluhach.png", "condition": "Прослухайте правильну вимову 10 слів у словнику."},
      {"title": "Відмінник", "progress": "4/15", "icon": "assets/vidminnuk.png", "condition": "Отримайте 15 балів за якість діалогів."},
      {"title": "Шеф", "progress": "3/20", "icon": "assets/shef.png", "condition": "Використайте підказку або стоп-слово 20 разів."},
      {"title": "Практик", "progress": "6/15", "icon": "assets/praktuck.png", "condition": "Складіть 15 розгорнутих речень (від 10 слів)."},
      {"title": "Хакер", "progress": "2/11", "icon": "assets/haker.png", "condition": "Отримайте всі інші досягнення."},
      {"title": "Папуга", "progress": "11/20", "icon": "assets/papuga.png", "condition": "Попросіть репетитора повторити фразу 30 разів."},
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/arrow.png', width: 24, height: 24, color: fontColor, errorBuilder: (c, e, s) => const Icon(Icons.arrow_back, color: fontColor)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          // Сильно збільшено бокові відступи (з 32 до 48), щоб картки стиснулися
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
          child: GridView.builder(
            itemCount: achievements.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 24, // Збільшено проміжок
              mainAxisSpacing: 24, // Збільшено проміжок
              childAspectRatio: 106 / 188, 
            ),
            itemBuilder: (context, index) {
              final item = achievements[index];
              final parts = item["progress"]!.split('/');
              final isCompleted = parts.length == 2 && parts[0] == parts[1];

              return GestureDetector(
                onTap: () => _showAchievementDialog(context, item["title"]!, item["progress"]!, item["icon"]!, item["condition"]!, isCompleted),
                child: Container(
                  decoration: BoxDecoration(color: isCompleted ? const Color(0xFFACBCD0) : Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(item["icon"]!, width: 58, height: 58, errorBuilder: (c, e, s) => const Icon(Icons.image, color: fontColor, size: 58)),
                      const SizedBox(height: 6), 
                      Text(item["title"]!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fontColor), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(item["progress"]!, style: const TextStyle(fontSize: 11, color: lightTextColor)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAchievementDialog(BuildContext context, String title, String progress, String imagePath, String condition, bool isCompleted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 80, height: 80, errorBuilder: (c, e, s) => const Icon(Icons.emoji_events, color: fontColor, size: 80)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: fontColor)),
            const SizedBox(height: 8),
            Text(condition, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: fontColor)),
            const SizedBox(height: 16),
            Text("Прогрес: $progress", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: lightTextColor)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: isCompleted ? const Color(0xFFACBCD0) : bgColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                onPressed: () => Navigator.pop(context),
                child: const Text("Зрозуміло", style: TextStyle(color: fontColor, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}