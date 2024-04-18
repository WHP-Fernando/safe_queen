import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SnakeGameScreen(),
  ));
}

class SnakeGameScreen extends StatefulWidget {
  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

enum Direction { up, down, left, right }

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int gridSize = 20;
  static const int cellSize = 20;
  static const Duration gameSpeed = Duration(milliseconds: 300);

  List<Point<int>> snake = [];
  Point<int> food = Point(0, 0);
  Direction direction = Direction.right;
  bool isPlaying = false;
  Timer? gameLoop;

  bool isPaused = false;

  @override
  void dispose() {
    gameLoop?.cancel(); // Cancel the timer
    super.dispose();
  }

  void startGame() {
    setState(() {
      snake.clear();
      snake.add(Point(gridSize ~/ 2, gridSize ~/ 2));
      snake.add(Point(gridSize ~/ 2 - 1, gridSize ~/ 2));
      snake.add(Point(gridSize ~/ 2 - 2, gridSize ~/ 2));
      food = generateFood();
      direction = Direction.right;
      isPlaying = true;
      gameLoop = Timer.periodic(gameSpeed, (Timer timer) => moveSnake());
    });
  }

  void endGame() {
    setState(() {
      isPlaying = false;
      gameLoop?.cancel();
    });
  }

  Point<int> generateFood() {
    Random random = Random();
    Point<int> food;
    do {
      food = Point<int>(random.nextInt(gridSize), random.nextInt(gridSize));
    } while (snake.contains(food));
    return food;
  }

  void moveSnake() {
    setState(() {
      Point<int> newHead = snake.first + directionOffset(direction);
      if (newHead.x < 0 ||
          newHead.x >= gridSize ||
          newHead.y < 0 ||
          newHead.y >= gridSize ||
          snake.sublist(1).contains(newHead)) {
        endGame();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('You hit the wall!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startGame(); // Start a new game
                  },
                  child: Text('Restart'),
                ),
              ],
            );
          },
        );
        return;
      }
      snake.insert(0, newHead);
      if (newHead == food) {
        food = generateFood();
      } else {
        snake.removeLast();
      }
    });
  }

  Point<int> directionOffset(Direction direction) {
    switch (direction) {
      case Direction.up:
        return Point(0, -1);
      case Direction.down:
        return Point(0, 1);
      case Direction.left:
        return Point(-1, 0);
      case Direction.right:
        return Point(1, 0);
    }
  }

  void togglePause() {
    setState(() {
      if (isPlaying) {
        isPaused = !isPaused;
        if (isPaused) {
          gameLoop?.cancel();
        } else {
          gameLoop = Timer.periodic(gameSpeed, (Timer timer) => moveSnake());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        title: Text(
          'Snake Game',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 253, 238, 252),
        child: GestureDetector(
          onTap: startGame, // Start the game when tapping
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: gridSize * cellSize.toDouble(),
                  height: gridSize * cellSize.toDouble(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Stack(
                    children: [
                      for (var segment in snake)
                        Positioned(
                          left: segment.x * cellSize.toDouble(),
                          top: segment.y * cellSize.toDouble(),
                          child: Container(
                            width: cellSize.toDouble(),
                            height: cellSize.toDouble(),
                            color: Colors.green,
                          ),
                        ),
                      Positioned(
                        left: food.x * cellSize.toDouble(),
                        top: food.y * cellSize.toDouble(),
                        child: Container(
                          width: cellSize.toDouble(),
                          height: cellSize.toDouble(),
                          color: Colors.red,
                        ),
                      ),
                      if (!isPlaying)
                        Center(
                          child: Text(
                            'Tap to start',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add some space between buttons and game area
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    GestureDetector(
      onTap: togglePause,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.redAccent),
        ),
        child: Center(
          child: Icon(
            isPaused ? Icons.play_arrow : Icons.pause,
            size: 20,
            color: Colors.redAccent,
          ),
        ),
      ),
    ),
  ],
),

                SizedBox(height: 20), // Add some space between buttons and game area
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (direction != Direction.down) direction = Direction.up;
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_upward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Add space between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (direction != Direction.left) direction = Direction.left;
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10), // Add space between buttons
                    GestureDetector(
                      onTap: () {
                        if (direction != Direction.down) direction = Direction.down;
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_downward, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10), // Add space between buttons
                    GestureDetector(
                      onTap: () {
                        if (direction != Direction.right) direction = Direction.right;
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
