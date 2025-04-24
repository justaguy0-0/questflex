import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final PageController _controller = PageController();
  bool _showSwipeHint = true;

  final List<Map<String, String>> history = [
    {
      'title': 'Основание компании',
      'content': 'В феврале 2005 года группа менеджеров, имеющих многолетний опыт автоматизации банковской деятельности, создает компанию Neoflex, сфокусированную на оказании профессиональных услуг в сфере IT для финансовых организаций. ',
      'mascot': 'assets/mascot/mascot5.png',
    },
    {
      'title': 'Рост и развитие',
      'content': 'В 2007 году клиентами Neoflex становится ряд иностранных банков, выстраивающих IT-ландшафты своих дочерних структур с учетом специфики деятельности в России.',
      'mascot': 'assets/mascot/mascot6.png',
    },
    {
      'title': 'Big Data',
      'content': 'В 2016 году Neoflex выполняет первые проекты с использованием технологий Big Data для создания решений класса IoT (интернет вещей), работы по анализу данных, а также проекты на основе микросервисной архитектуры',
      'mascot': 'assets/mascot/mascot1.png',
    },
    {
      'title': 'Пройти тест',
      'content': 'Проверь, как хорошо ты узнал нашу компанию!',
      'mascot': 'assets/mascot/mascot3.png',
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
                colors: [Color(0xFFB5D5FF), Color(0xFFECEAFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // PageView с карточками
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
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          final item = history[index];
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
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway',
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          maxLines: null,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          item['content']!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Raleway',
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          maxLines: null,
                                        ),
                                        const SizedBox(height: 30),
                                        if (isButtonCard)
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => const QuizScreen(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[700],
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12)),
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

                  // Кнопка "На главную" под карточками
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.home, color: Colors.indigo),
                      label: const Text(
                        'На главную',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.indigo,
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
                        textAlign: TextAlign.center,  // Добавлено выравнивание по центру
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