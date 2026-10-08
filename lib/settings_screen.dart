import 'package:flutter/material.dart';
import 'main.dart'; 

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _voices = [
    'Американський акцент (Жіночий)',
    'Американський акцент (Чоловічий)',
    'Британський акцент (Жіночий)',
    'Британський акцент (Чоловічий)',
    'Австралійський акцент',
  ];

  final List<String> _aiAvatars = ['🐶', '🐦', '🕷️', '🐍', '🐱', '🦉'];

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10, top: 24),
      child: Text(
        title,
        style: const TextStyle(color: fontColor, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isFocus = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(icon, color: isFocus ? const Color(0xFFE57373) : fontColor),
      title: Text(
        title,
        style: TextStyle(
          color: isFocus ? const Color(0xFFE57373) : fontColor,
          fontWeight: isFocus ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.2)) : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: isFocus ? const Color(0xFFE57373) : fontColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text("Налаштування", style: TextStyle(color: fontColor, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: fontColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Налаштування ШІ"),
            _buildSettingsCard(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Голос та тембр", style: TextStyle(color: fontColor, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: globalSelectedVoice, // Зчитуємо глобальну змінну
                        icon: const Icon(Icons.expand_more, color: fontColor),
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: fontColor)),
                        ),
                        items: _voices.map((String voice) {
                          return DropdownMenuItem(value: voice, child: Text(voice, style: const TextStyle(fontSize: 14, color: fontColor)));
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => globalSelectedVoice = newValue); // Зберігаємо глобально
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Аватар ШІ", style: TextStyle(color: fontColor, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 56,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _aiAvatars.length,
                          itemBuilder: (context, index) {
                            final isSelected = globalSelectedAiAvatar == index;
                            return GestureDetector(
                              onTap: () => setState(() => globalSelectedAiAvatar = index), // Зберігаємо глобально
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(right: 12),
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: isSelected ? fontColor : Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: isSelected ? fontColor : Colors.transparent, width: 2),
                                ),
                                alignment: Alignment.center,
                                child: Text(_aiAvatars[index], style: const TextStyle(fontSize: 28)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _buildSectionHeader("Керування сповіщеннями"),
            _buildSettingsCard(
              children: [
                _buildSwitchTile(
                  title: "Режим фокусу",
                  subtitle: "Глушить сповіщення усіх інших додатків під час використання Englysysh",
                  icon: Icons.do_not_disturb_on,
                  value: globalFocusMode,
                  isFocus: true,
                  onChanged: (val) {
                    setState(() {
                      globalFocusMode = val;
                      if (val) {
                        globalNotifLessons = false;
                        globalNotifAchievements = false;
                        globalNotifDaily = false;
                      }
                    });
                  },
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _buildSwitchTile(
                  title: "Нагадування про заняття",
                  icon: Icons.menu_book,
                  value: globalNotifLessons,
                  onChanged: globalFocusMode ? (_) {} : (val) => setState(() => globalNotifLessons = val),
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _buildSwitchTile(
                  title: "Нові досягнення",
                  icon: Icons.emoji_events_outlined,
                  value: globalNotifAchievements,
                  onChanged: globalFocusMode ? (_) {} : (val) => setState(() => globalNotifAchievements = val),
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _buildSwitchTile(
                  title: "Щоденний звіт",
                  icon: Icons.bar_chart,
                  value: globalNotifDaily,
                  onChanged: globalFocusMode ? (_) {} : (val) => setState(() => globalNotifDaily = val),
                ),
              ],
            ),

            _buildSectionHeader("Вигляд"),
            _buildSettingsCard(
              children: [
                _buildSwitchTile(
                  title: "Темна тема",
                  icon: Icons.dark_mode_outlined,
                  value: globalDarkModeEnabled,
                  onChanged: (val) => setState(() => globalDarkModeEnabled = val),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}