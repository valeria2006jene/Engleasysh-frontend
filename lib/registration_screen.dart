import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'main.dart'; 

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _obscurePassword = true;

  String? _validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) return 'Поле не може бути порожнім';
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^\+[1-9]\d{1,14}$');

    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return 'Введіть коректний email або телефон (з +)';
    }
    return null;
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Політика конфіденційності", style: TextStyle(color: fontColor, fontWeight: FontWeight.bold)),
        content: const SingleChildScrollView(
          child: Text(
            "Останнє оновлення: 21 вересня 2026 р.\n\n"
            "1. Збір даних\n"
            "Ми збираємо мінімальний набір даних, необхідний для роботи Engleasysh: email або номер телефону (для авторизації), нікнейм, налаштування та дані про прогрес навчання.\n\n"
            "2. Використання даних\n"
            "Ваші дані використовуються виключно для забезпечення функціоналу застосунку, персоналізації ШІ-репетитора та збереження вашого прогресу. Ми не продаємо ваші дані третім особам.\n\n"
            "3. Безпека\n"
            "Ми застосовуємо сучасні стандарти захисту для збереження ваших облікових та особистих даних.\n\n"
            "4. Ваші права\n"
            "Ви можете будь-коли відредагувати свої дані або надіслати запит на повне видалення акаунту через налаштування профілю.\n\n"
            "Продовжуючи реєстрацію, ви погоджуєтесь з цими умовами.",
            style: TextStyle(fontSize: 14, color: fontColor),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Зрозуміло", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isChecked) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigator(initialIndex: 0)),
        (route) => false,
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      // ЗАПИСУЄМО ДАНІ В ГЛОБАЛЬНІ ЗМІННІ
      globalUserName = 'USER';
      globalUserAvatar = 'https://cdn-icons-png.flaticon.com/512/2991/2991148.png'; 
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Успішний тестовий вхід: $globalUserName')),
      );

      // ВИКЛИКАЄМО НАВІГАТОР БЕЗ ПАРАМЕТРІВ
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigator(initialIndex: 0),
        ),
        (route) => false,
      );
    }
  }

  Widget _buildInputCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Створити акаунт",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: fontColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildInputCard(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email або Номер телефону',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                      validator: _validateEmailOrPhone,
                    ),
                  ),
                  _buildInputCard(
                    child: TextFormField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) => value != null && value.length < 6 
                          ? 'Пароль має містити мінімум 6 символів' : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        activeColor: fontColor,
                        onChanged: (value) => setState(() => _isChecked = value ?? false),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                            children: [
                              const TextSpan(text: "Я погоджуюсь з "),
                              TextSpan(
                                text: "Політикою конфіденційності",
                                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()..onTap = _showPrivacyPolicy,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isChecked ? _submitForm : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fontColor,
                      disabledBackgroundColor: Colors.grey.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Продовжити / Зареєструватися", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  const Center(child: Text("або", style: TextStyle(color: Colors.grey))),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: _isChecked ? _signInWithGoogle : null,
                    icon: Image.network(
                      'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                      height: 24,
                    ),
                    label: Text(
                      "Увійти через Google", 
                      style: TextStyle(color: _isChecked ? fontColor : Colors.grey, fontWeight: FontWeight.bold)
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}