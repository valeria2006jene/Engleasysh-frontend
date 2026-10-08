import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'widgets.dart' show SafeAvatar; 

class ProfileEditScreen extends StatefulWidget {
  final String? initialName;
  final String? initialAvatar;

  const ProfileEditScreen({super.key, this.initialName, this.initialAvatar});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _statusController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Тягнемо початкові дані з глобальних змінних
    _nameController = TextEditingController(text: globalUserName);
    _statusController = TextEditingController(text: globalUserStatus);
    _phoneController = TextEditingController(text: globalUserPhone);
    _emailController = TextEditingController(text: globalUserEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveChanges() {
    // ЗБЕРІГАЄМО ВСЕ У ГЛОБАЛЬНІ ЗМІННІ
    globalUserName = _nameController.text;
    globalUserAvatar = _selectedImage != null ? _selectedImage!.path : globalUserAvatar;
    globalUserStatus = _statusController.text; 
    globalUserPhone = _phoneController.text; 
    globalUserEmail = _emailController.text; 

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Дані успішно оновлено!')),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigator(initialIndex: 0),
      ),
      (route) => false,
    );
  }

  void _showPasswordChangeDialog() {
    bool obscureOld = true;
    bool obscureNew = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: const Text("Зміна пароля", style: TextStyle(color: fontColor, fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    obscureText: obscureOld,
                    decoration: InputDecoration(
                      labelText: "Старий пароль",
                      suffixIcon: IconButton(
                        icon: Icon(obscureOld ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                        onPressed: () => setModalState(() => obscureOld = !obscureOld),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: obscureNew,
                    decoration: InputDecoration(
                      labelText: "Новий пароль",
                      suffixIcon: IconButton(
                        icon: Icon(obscureNew ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                        onPressed: () => setModalState(() => obscureNew = !obscureNew),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Скасувати", style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fontColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пароль змінено')));
                  },
                  child: const Text("Зберегти", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }
        );
      },
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Відображаємо локальне фото, якщо вибрали нове, інакше — беремо з глобальної змінної
    String currentAvatar = _selectedImage != null 
        ? _selectedImage!.path 
        : globalUserAvatar;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text("Редагування", style: TextStyle(color: fontColor, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: fontColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SafeAvatar(url: currentAvatar, radius: 50),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: fontColor, 
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildCard(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Нікнейм',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            _buildCard(
              child: TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Статус',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Контакти", style: TextStyle(color: fontColor, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 10),
            _buildCard(
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Номер телефону',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            _buildCard(
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Безпека", style: TextStyle(color: fontColor, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 10),
            _buildCard(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                title: const Text("Змінити пароль", style: TextStyle(color: fontColor, fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: _showPasswordChangeDialog,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: fontColor,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Зберегти", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}