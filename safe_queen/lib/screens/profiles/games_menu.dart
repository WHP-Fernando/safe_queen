import 'package:flutter/material.dart'; 
import 'package:safe_queen/screens/profiles/games%20list/empower_questgame.dart';
import 'package:safe_queen/screens/profiles/games%20list/Quiz.dart';
import 'package:safe_queen/screens/profiles/games%20list/snake_game.dart';

void main() {
  runApp(GameMenu());
}

class GameMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 253, 238, 252),
          title: Text(
            'Game Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back to previous screen
            },
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 253, 238, 252),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GameButton(
                  gameName: 'Snake Game',
                  onPressed: () {
                    // Navigate to Game 1
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SnakeGameScreen()),
                );
              },
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: GameButton(
                  gameName: 'Empower Quest',
                  onPressed: () {
                    // Navigate to Game 2
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmpowermentQuestGame()),
                );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: GameButton(
                  gameName: 'Quiz',
                  onPressed: () {
                    // Navigate to Game 3
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WomenEmpowermentQuiz()),
                );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String gameName;
  final VoidCallback onPressed;

  GameButton({required this.gameName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        gameName,
        style: TextStyle(fontSize: 20.0),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(40.0),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          CircleBorder(side: BorderSide(color: Colors.pinkAccent, width: 4.0)),
        ),
      ),
    );
  }
}
