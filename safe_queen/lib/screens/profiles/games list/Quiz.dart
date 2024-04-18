import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: WomenEmpowermentQuiz(),
  ));
}

class WomenEmpowermentQuiz extends StatefulWidget {
  @override
  _WomenEmpowermentQuizState createState() => _WomenEmpowermentQuizState();
}

class _WomenEmpowermentQuizState extends State<WomenEmpowermentQuiz> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who was the first female Prime Minister of Sri Lanka?',
      'options': ['Ranasinghe Premadasa', 'Chandrika Kumaratunga', 'Sirimavo Bandaranaike', 'Indira Gandhi'],
      'correctAnswer': 'Sirimavo Bandaranaike',
    },
    {
      'question': 'Which Sri Lankan woman cricketer holds the record for the highest individual score in Women\'s One Day Internationals (ODIs)?',
      'options': ['Shashikala Siriwardene', 'Chamari Atapattu', 'Mithali Raj', 'Suzie Bates'],
      'correctAnswer': 'Chamari Atapattu',
    },
     {
      'question': 'Who was the first woman to win a Nobel Prize?',
      'options': ['Marie Curie', 'Rosalind Franklin', 'Jane Goodall', 'Florence Nightingale'],
      'correctAnswer': 'Marie Curie',
    },
    {
      'question': 'Who is known as the first female Sri Lankan to win an Olympic medal?',
      'options': ['Anuradha Cooray', 'Sunette Viljoen', 'Hiruni Wijayarathne', 'Susanthika Jayasinghe'],
      'correctAnswer': 'Susanthika Jayasinghe',
    },
    {
      'question': 'Which woman led the movement for women\'s right to vote in the United States?',
      'options': ['Susan B. Anthony', 'Harriet Tubman', 'Elizabeth Cady Stanton', 'Rosa Parks'],
      'correctAnswer': 'Susan B. Anthony',
    },
    {
      'question': 'Which Sri Lankan woman became the first female to serve as a Chief Justice of the Supreme Court of Sri Lanka?',
      'options': ['Chitrasiri Ekanayake', 'Sathya Hettige', 'Shirani Bandaranayake', 'Eva Wanasundera'],
      'correctAnswer': 'Shirani Bandaranayake',
    },
    {
      'question': 'Who was the first female Prime Minister of India?',
      'options': ['Margaret Thatcher', 'Golda Meir', 'Benazir Bhutto', 'Indira Gandhi'],
      'correctAnswer': 'Indira Gandhi',
    },
    {
      'question': 'Who wrote the book "Lean In: Women, Work, and the Will to Lead"?',
      'options': ['Sheryl Sandberg', 'Oprah Winfrey', 'Malala Yousafzai', 'Gloria Steinem'],
      'correctAnswer': 'Sheryl Sandberg',
    },
    {
      'question': 'Who was the first woman to fly solo across the Atlantic Ocean?',
      'options': ['Amelia Earhart', 'Bessie Coleman', 'Harriet Quimby', 'Amy Johnson'],
      'correctAnswer': 'Amelia Earhart',
    },
    {
      'question': 'Who is often credited with writing the first modern feminist work, "A Vindication of the Rights of Woman?',
      'options': ['Simone de Beauvoir', 'Mary Wollstonecraft', 'Virginia Woolf', 'Betty Friedan'],
      'correctAnswer': 'Mary Wollstonecraft',
    },
  ];

  final _databaseReference = FirebaseDatabase.instance.reference();

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      if (_questions[_currentQuestionIndex]['correctAnswer'] == selectedAnswer) {
        _score++;
      }
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // End of quiz
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    String correctAnswers = '';
    for (int i = 0; i < _questions.length; i++) {
      correctAnswers +=
          '${i + 1}. ${_questions[i]['question']}\nCorrect Answer: ${_questions[i]['correctAnswer']}\n\n';
    }

    // Store quiz results in Firebase Realtime Database
    _databaseReference.child('quiz_results').push().set({
      'score': _score,
      'total_questions': _questions.length,
      'timestamp': DateTime.now().toString(),
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You scored $_score out of ${_questions.length}'),
                SizedBox(height: 20),
                Text('Correct Answers:'),
                SizedBox(height: 10),
                Text(correctAnswers),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Try Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        title: Text(
          'Women Empowerment Quiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex]['question'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ...(_questions[_currentQuestionIndex]['options'] as List<String>).map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(option),
                  child: Text(option),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
