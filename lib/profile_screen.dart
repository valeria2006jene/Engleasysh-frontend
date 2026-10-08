import 'package:flutter/material.dart';
import 'main.dart' show globalUserStatus; 
import 'widgets.dart';
import 'achievements_screen.dart';
import 'profile_edit_screen.dart'; 
import 'settings_screen.dart'; // ПІДКЛЮЧЕНО ЕКРАН НАЛАШТУВАНЬ

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    const double horizontalScreenPadding = 50;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/arrow.png', width: 24, height: 24, color: fontColor, errorBuilder: (c, e, s) => const Icon(Icons.arrow_back, color: fontColor)),
          onPressed: () => Navigator.pop(context), 
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/options.png', width: 24, height: 24, color: fontColor, errorBuilder: (c, e, s) => const Icon(Icons.settings_outlined, color: fontColor)),
            onPressed: () {
              // ПЕРЕХІД НА НАЛАШТУВАННЯ
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeAvatar(url: avatarUrl, radius: 35), 
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: fontColor)),
                        const SizedBox(height: 4),
                        Text(globalUserStatus, style: const TextStyle(fontSize: 13, color: lightTextColor)),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditScreen(
                                  initialName: userName,
                                  initialAvatar: avatarUrl,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: const Text("Редагувати профіль", style: TextStyle(color: fontColor, fontSize: 13, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text("Statistics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: fontColor)),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20, 
                mainAxisSpacing: 20,  
                childAspectRatio: 169 / 153, 
                children: [
                  _buildStatCard("8.5", "Бали", "assets/Trend.png"),
                  _buildStatCard("21", "Вивчені слова", "assets/wbook.png"),
                  _buildStatCard("6", "Кількість днів поспіль", "assets/day.png"),
                  _buildStatCard("8h 30m", "Час у розмовах", "assets/timespeak.png"),
                ],
              ),
              const SizedBox(height: 32),
              const Text("Achievements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: fontColor)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAchievementPreview(context, "В ударі", "6/7", "assets/vydari.png", false, "Тримайте активність 7 днів поспіль."),
                  _buildAchievementPreview(context, "Словопліт", "21/35", "assets/slovoplit.png", false, "Вивчіть 35 слів."),
                  _buildAchievementPreview(context, "Рання пташка", "2/5", "assets/rannyaptashka.png", false, "Провести 5 ранкових занять (до 09:00)."),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AchievementsScreen())),
                  child: const Text("Переглянути всі досягнення", style: TextStyle(color: fontColor, fontSize: 14, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, String imagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 41, height: 41, errorBuilder: (c, e, s) => const Icon(Icons.analytics_outlined, color: fontColor, size: 41)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: fontColor, height: 1.1)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: lightTextColor)),
        ],
      ),
    );
  }

  Widget _buildAchievementPreview(BuildContext context, String title, String progress, String imagePath, bool isCompleted, String condition) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _showAchievementDialog(context, title, progress, imagePath, condition, isCompleted),
        child: AspectRatio(
          aspectRatio: 106 / 188, 
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6), 
            decoration: BoxDecoration(color: isCompleted ? const Color(0xFFACBCD0) : Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imagePath, width: 58, height: 58, errorBuilder: (c, e, s) => const Icon(Icons.emoji_events, color: fontColor, size: 58)),
                const SizedBox(height: 8), 
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fontColor), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(progress, style: const TextStyle(fontSize: 11, color: lightTextColor)),
              ],
            ),
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