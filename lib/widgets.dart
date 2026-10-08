import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'profile_screen.dart'; 
import 'settings_screen.dart'; // ПІДКЛЮЧЕНО ЕКРАН НАЛАШТУВАНЬ

const Color bgColor = Color(0xFFDEE6F2);
const Color fontColor = Color(0xFF2D4B63);
const Color lightTextColor = Color(0xFF6D88A5);

class SafeAvatar extends StatelessWidget {
  final String url;
  final double radius;

  const SafeAvatar({super.key, required this.url, required this.radius});

  @override
  Widget build(BuildContext context) {
    final bool isNetwork = url.startsWith('http') || url.startsWith('blob:') || kIsWeb;
    final double size = radius * 2;

    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Colors.white,
        child: url.isEmpty
            ? Icon(Icons.person, size: radius, color: fontColor)
            : (isNetwork
                ? Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Icon(Icons.error_outline, size: radius, color: Colors.red),
                  )
                : Image.file(
                    File(url),
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Icon(Icons.broken_image, size: radius, color: Colors.red),
                  )),
      ),
    );
  }
}

class HeaderLeft extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const HeaderLeft({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      userName: userName,
                      avatarUrl: avatarUrl,
                    ),
                  ),
                );
              },
              child: SafeAvatar(url: avatarUrl, radius: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hi,",
                  style: TextStyle(fontSize: 14, color: lightTextColor),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Image.asset(
            'assets/options.png',
            width: 24,
            height: 24,
            color: fontColor,
          ),
          onPressed: () {
            // ПЕРЕХІД НА НАЛАШТУВАННЯ
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ],
    );
  }
}

class HeaderRight extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const HeaderRight({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/options.png',
            width: 24,
            height: 24,
            color: fontColor,
          ),
          onPressed: () {
            // ПЕРЕХІД НА НАЛАШТУВАННЯ
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Hi,",
                  style: TextStyle(fontSize: 12, color: lightTextColor),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: fontColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      userName: userName,
                      avatarUrl: avatarUrl,
                    ),
                  ),
                );
              },
              child: SafeAvatar(url: avatarUrl, radius: 18),
            ),
          ],
        ),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String text;
  final String time;

  const NotificationCard({
    super.key,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: fontColor,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: const TextStyle(fontSize: 11, color: lightTextColor),
          ),
        ],
      ),
    );
  }
}

class WeekStrikeWidget extends StatelessWidget {
  const WeekStrikeWidget({super.key});

  List<Map<String, dynamic>> generateWeek() {
    DateTime today = DateTime.now();
    List<String> weekDays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
    List<Map<String, dynamic>> week = [];

    for (int i = -3; i <= 3; i++) {
      DateTime date = today.add(Duration(days: i));
      Color color = Colors.transparent;

      if (i < 0) {
        color = i.isEven ? const Color(0xFFE8DFE5) : const Color(0xFFD8E1EA);
      }
      if (i == 0) {
        color = const Color(0xFFC7E2F1);
      }
      week.add({
        "number": date.day.toString(),
        "day": weekDays[date.weekday - 1],
        "color": color,
        "today": i == 0,
      });
    }
    return week;
  }

  @override
  Widget build(BuildContext context) {
    final days = generateWeek();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((day) {
          return Column(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: day["color"],
                  shape: BoxShape.circle,
                  border: day["today"]
                    ? Border.all(color: Colors.white, width: 2)
                    : null,
                ),
                child: Text(
                  day["number"],
                  style: const TextStyle(fontSize: 14, color: fontColor),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                day["day"],
                style: const TextStyle(fontSize: 11, color: fontColor),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}