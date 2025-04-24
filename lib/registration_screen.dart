import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  final TextEditingController nameController = TextEditingController();
  int selectedAvatar = 0;
  List<String> avatarPaths = List.generate(6, (i) => 'assets/avatars/avatar_$i.jpg');

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text.trim());
    await prefs.setInt('avatarIndex', selectedAvatar);
    await prefs.setInt('score', 0);
    await prefs.setBool('isRegistered', true);

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void nextPage() => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  void previousPage() => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Raleway'),
          titleLarge: TextStyle(fontFamily: 'Raleway'),
          labelLarge: TextStyle(fontFamily: 'Raleway'),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFCFDEF3),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildCard(
              title: "Как тебя зовут?",
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(fontFamily: 'Raleway'),
                    decoration: const InputDecoration(
                      hintText: "Введи имя",
                      hintStyle: TextStyle(fontFamily: 'Raleway'),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty) {
                        nextPage();
                      }
                    },
                    child: const Text(
                      "Далее",
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                  ),
                ],
              ),
            ),
            _buildCard(
              title: "Выбери аватар",
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 400,
                    child: GridView.builder(
                      itemCount: avatarPaths.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => setState(() => selectedAvatar = index),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedAvatar == index ? Colors.indigo : Colors.transparent,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                avatarPaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: previousPage,
                        child: const Text(
                          "Назад",
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: nextPage,
                        child: const Text(
                          "Далее",
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            _buildCard(
              title: "Привет, ${nameController.text.trim().isNotEmpty ? nameController.text.trim() : "друг"}!",
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(avatarPaths[selectedAvatar]),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Готов(а) к приключению?",
                    style: TextStyle(fontSize: 18, fontFamily: 'Raleway'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text(
                      "Начать",
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    onPressed: saveProfile,
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: previousPage,
                    child: const Text(
                      "Назад",
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(4, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              child,
            ],
          ),
        ),
      ),
    );
  }
}