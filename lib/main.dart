import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history_screen.dart';
import 'registration_screen.dart';
import 'education_screen.dart';
import 'culture_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isRegistered = prefs.getBool('isRegistered') ?? false;
  runApp(MyApp(startAtHome: isRegistered));
}

class MyApp extends StatelessWidget {
  final bool startAtHome;
  const MyApp({super.key, required this.startAtHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quest Flex',
      theme: ThemeData(
        fontFamily: 'Raleway',
        useMaterial3: true,
      ),
      home: startAtHome ? const HomeScreen() : const RegistrationScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _loadUserData();
  }

  Future<Map<String, dynamic>> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('username') ?? 'Гость',
      'avatarIndex': prefs.getInt('avatarIndex') ?? 0,
      'score': prefs.getInt('score') ?? 0,
    };
  }

  void _refreshUserData() {
    setState(() {
      _userData = _loadUserData();  // Обновляем данные, переписывая Future
    });
  }

  // Функция для обновления баллов в SharedPreferences
  void _updateScore(int newScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', newScore);
    _refreshUserData();  // Обновляем данные после изменения баллов
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final name = snapshot.data!['name'];
        final avatarIndex = snapshot.data!['avatarIndex'];
        final score = snapshot.data!['score'];

        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Профиль
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/avatars/avatar_$avatarIndex.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$name",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Баллы: $score",
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Кнопки
                  _modernButton(
                    context,
                    icon: Icons.book,
                    label: "История",
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                      _refreshUserData();
                    },
                  ),
                  const SizedBox(height: 16),
                  _modernButton(
                    context,
                    icon: Icons.school,
                    label: "Образование",
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => EducationScreen()));
                      _refreshUserData();
                    },
                  ),
                  const SizedBox(height: 16),
                  _modernButton(
                    context,
                    icon: Icons.person_3,
                    label: "Культура и ценности",
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const CultureScreen()));
                      _refreshUserData();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _modernButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.indigo, size: 28),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}