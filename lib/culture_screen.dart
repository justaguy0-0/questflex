import 'package:flutter/material.dart';
import 'package:questflex/quiz_screen.dart';
import 'quiz_cul_screen.dart';

class CultureScreen extends StatefulWidget {
  const CultureScreen({Key? key}) : super(key: key);

  @override
  State<CultureScreen> createState() => _CultureScreenState();
}

class _CultureScreenState extends State<CultureScreen> {
  final PageController _controller = PageController();
  bool _showSwipeHint = true;

  final List<Map<String, String>> culture = [
    {
      'title': 'Ценности Neoflex',
      'content': 'Neoflex строит свою корпоративную культуру на четырёх ключевых ценностях: клиентоцентричности, экспертизе, партнёрстве и ответственности.',
      'mascot': 'assets/mascot/mascot8.png',
    },
    {
      'title': 'Корпоративная культура',
      'content': 'Компания уделяет особое внимание балансу работы и личной жизни сотрудников, предлагая гибкий график, удалённую работу, wellness-программы (спорт, ДМС, антистресс-курсы).',
      'mascot': 'assets/mascot/mascot7.png',
    },
    {
      'title': 'Внутренние инициативы',
      'content': 'А также развивает внутренние инициативы — NeoCommunity для обмена знаниями, NeoCharity для благотворительности и NeoTime для реализации личных проектов.',
      'mascot': 'assets/mascot/mascot4.png',
    },
    {
      'title': 'Пройти тест',
      'content': 'Готов ли ты стать частью культуры Neoflex? Проверь себя!',
      'mascot': 'assets/mascot/mascot5.png',
      'isButton': 'true',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9D63B1), Color(0xFFF3D1FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_showSwipeHint) {
                          setState(() {
                            _showSwipeHint = false;
                          });
                        }
                      },
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: culture.length,
                        itemBuilder: (context, index) {
                          final item = culture[index];
                          final isButtonCard = item['isButton'] == 'true';

                          return Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              color: Colors.white,
                              elevation: 10,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item['title']!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway',
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          item['content']!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Raleway',
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        if (isButtonCard)
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => const CultureQuizScreen(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.pink[300],
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Начать тест',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    child: Image.asset(
                                      item['mascot']!,
                                      height: 80,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.home, color: Colors.pinkAccent),
                      label: const Text(
                        'На главную',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Полноэкранная подсказка о свайпе
          if (_showSwipeHint)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showSwipeHint = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.85),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.swipe_left,
                        color: Colors.white,
                        size: 60,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Свайпните влево, чтобы\nперейти к следующей карточке',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Коснитесь экрана, чтобы продолжить',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}