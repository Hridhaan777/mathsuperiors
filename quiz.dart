import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Math Quiz")),
        body: QuizWidget(level: 1),
      ),
    );
  }
}

class QuizWidget extends StatefulWidget {
  final int level;
  const QuizWidget({Key? key, this.level = 1}) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int questionIndex = 0;
  int score = 0;

  final Map<int, List<Map<String, Object>>> levelQuestions = {
    1: [
      {
        'question': 'What is 7 × 8?',
        'answers': [
          {'text': '54', 'correct': false},
          {'text': '56', 'correct': true},
          {'text': '64', 'correct': false},
        ],
      },
      {
        'question': 'What is 12 ÷ 4?',
        'answers': [
          {'text': '2', 'correct': false},
          {'text': '3', 'correct': true},
          {'text': '4', 'correct': false},
        ],
      },
    ]
  };

  void answerQuestion(bool correct) {
    if (correct) score++;
    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = levelQuestions[widget.level]!;
    if (questionIndex < questions.length) {
      var q = questions[questionIndex];
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            q['question'] as String,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...(q['answers'] as List<Map<String, Object>>).map((ans) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: ElevatedButton(
                child: Text(ans['text'] as String,
                    style: const TextStyle(fontSize: 20)),
                onPressed: () => answerQuestion(ans['correct'] as bool),
              ),
            );
          }).toList(),
        ],
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("🎉 Quiz Complete! 🎉",
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                questions.length,
                (i) => Icon(
                  Icons.star,
                  size: 40,
                  color: i < score ? Colors.yellow : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}