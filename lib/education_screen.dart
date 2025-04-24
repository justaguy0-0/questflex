import 'package:flutter/material.dart';
import 'quiz_edu_screen.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final PageController _controller = PageController();
  bool _showSwipeHint = true;

  final List<Map<String, String>> education = [
    {
      'title': 'Образовательные программы',
      'content': 'Учебный центр Neoflex предлагает бесплатные онлайн-курсы с возможностью трудоустройства для лучших выпускников. Обучение длится до 3,5 месяцев и включает 70% практики.',
      'mascot': 'assets/mascot/mascot1.png',
    },
    {
      'title': 'Neoskills Lab',
      'content': 'В 2023 году Neoflex запустила проект Neoskills Lab — бесплатные курсы для переквалификации IT-специалистов в направлениях ETL-процессов и нагрузочного тестирования.',
      'mascot': 'assets/mascot/mascot2.png',
    },
    {
      'title': 'Трудоустройство',
      'content': '470 выпускников Учебного центра трудоустроены в Neoflex, а всего обучение прошли 1270 человек.',
      'mascot': 'assets/mascot/mascot8.png',
    },
    {
      'title': 'Реальные кейсы',
      'content': 'Среди заказчиков Neoflex — более половины топ-100 российских банков, что дает студентам возможность работать с реальными кейсами.',
      'mascot': 'assets/mascot/mascot8.png',
    },
    {
      'title': 'Пройти тест',
      'content': 'Проверь, как хорошо ты усвоил образовательный блок!',
      'mascot': 'assets/mascot/mascot4.png',
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
                colors: [Color(0xFF59A84D), Color(0xFFD7FFD1)],
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
                        itemCount: education.length,
                        itemBuilder: (context, index) {
                          final item = education[index];
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
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          maxLines: null,
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
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          maxLines: null,
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
                                                  builder: (_) => const EducationQuizScreen(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green[700],
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Начать тест',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              maxLines: null,
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
                      icon: const Icon(Icons.home, color: Colors.green),
                      label: const Text(
                        'На главную',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
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