import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationQuizScreen extends StatefulWidget {
  const EducationQuizScreen({Key? key}) : super(key: key);

  @override
  State<EducationQuizScreen> createState() => _EducationQuizScreenState();
}

class _EducationQuizScreenState extends State<EducationQuizScreen>
    with TickerProviderStateMixin {
  int _score = 0;
  int _questionIndex = 0;
  bool _isFinished = false;
  late AnimationController _resultsController;
  late Animation<double> _animation;
  late AnimationController _questionController;
  late Animation<double> _questionAnimation;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Какой процент обучения в Учебном центре Neoflex составляет практика?',
      'answers': [
        {'text': '30%', 'score': 0},
        {'text': '70%', 'score': 1},
        {'text': '90%', 'score': 0},
      ]
    },
    {
      'question': 'Как называется проект Neoflex для переквалификации IT-специалистов?',
      'answers': [
        {'text': 'NeoStudy', 'score': 0},
        {'text': 'NeoAcademy', 'score': 0},
        {'text': 'Neoskills Lab', 'score': 1},
      ]
    },
    {
      'question': 'С какими клиентами Neoflex чаще всего работают, что дает студентам доступ к реальным кейсам?',
      'answers': [
        {'text': 'Розничные сети', 'score': 0},
        {'text': 'Банки из топ-100 России', 'score': 1},
        {'text': 'Государственные учреждения', 'score': 0},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _resultsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _resultsController,
        curve: Curves.elasticOut,
      ),
    );

    _questionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _questionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _questionController,
        curve: Curves.easeInOut,
      ),
    );

    // Запускаем анимацию появления первого вопроса
    _questionController.forward();
  }

  @override
  void dispose() {
    _resultsController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _answerQuestion(int score) async {
    // Анимация исчезновения текущего вопроса
    await _questionController.reverse();

    setState(() {
      _score += score;
      _questionIndex++;
      if (_questionIndex >= _questions.length) {
        _isFinished = true;
        _resultsController.forward();
        _saveScore();
      }
    });

    // Если тест не закончен, анимируем появление следующего вопроса
    if (!_isFinished) {
      _questionController.forward();
    }
  }

  Future<void> _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    int oldScore = prefs.getInt('score') ?? 0;
    await prefs.setInt('score', oldScore + _score);
  }

  void _exitQuiz() async {
    if (mounted) {
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF73B470), Color(0xFFB8E2B6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 10,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: _isFinished
                              ? _buildResultsScreen()
                              : _buildQuestionScreen(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: TextButton(
                    onPressed: _exitQuiz,
                    child: const Text(
                      'Выйти из теста',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ты набрал:',
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          ScaleTransition(
            scale: _animation,
            child: Text(
              '$_score баллов!',
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
              maxLines: null,
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _exitQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'На главную',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuestionScreen() {
    return FadeTransition(
      opacity: _questionAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _questions[_questionIndex]['question'] as String,
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: null,
          ),
          const SizedBox(height: 30),
          ...(_questions[_questionIndex]['answers']
          as List<Map<String, Object>>)
              .map(
                (answer) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                onPressed: () => _answerQuestion(answer['score'] as int),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  answer['text'] as String,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  maxLines: null,
                  style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}