// ignore: unused_import
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: EmpowermentQuestGame(),
  ));
}

class EmpowermentQuestGame extends StatefulWidget {
  @override
  _EmpowermentQuestGameState createState() => _EmpowermentQuestGameState();
}

class _EmpowermentQuestGameState extends State<EmpowermentQuestGame> {
  static const int gridSize = 10;
  static const int cellSize = 30;

  List<Point<int>> obstacles = [];
  Point<int> playerPosition = Point(0, 0);
  Point<int> targetPosition = Point(gridSize - 1, gridSize - 1);

  bool isGameInProgress = false;
  int currentLevel = 1;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      obstacles = _generateObstacles();
      playerPosition = Point(0, 0);
      isGameInProgress = true;
    });
  }

  List<Point<int>> _generateObstacles() {
    List<Point<int>> obstacles = [];
    Random random = Random();
    for (int i = 0; i < gridSize * gridSize * 0.1 * currentLevel; i++) {
      Point<int> obstacle = Point(random.nextInt(gridSize), random.nextInt(gridSize));
      if (obstacle != targetPosition && obstacle != playerPosition) {
        obstacles.add(obstacle);
      }
    }
    return obstacles;
  }

  void movePlayer(Point<int> newPosition) {
    if (!isGameInProgress) return;

    if (_isValidPosition(newPosition)) {
      setState(() {
        playerPosition = newPosition;
        if (playerPosition == targetPosition) {
          _handleLevelCompletion();
        }
      });
    }
  }

  bool _isValidPosition(Point<int> position) {
    return position.x >= 0 &&
        position.x < gridSize &&
        position.y >= 0 &&
        position.y < gridSize &&
        !obstacles.contains(position);
  }

  void _handleLevelCompletion() {
    setState(() {
      isGameInProgress = false;
      currentLevel++;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You completed Level $currentLevel!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame(); // Start the next level
              },
              child: Text('Next Level'),
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      currentLevel = 1;
      startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        title: Text('Empowerment Quest - Level $currentLevel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252),  
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
              ),
              itemBuilder: (BuildContext context, int index) {
                int x = index % gridSize;
                int y = index ~/ gridSize;
                Point<int> position = Point(x, y);
                if (position == playerPosition) {
                  return Container(
                    color: Colors.pinkAccent,
                    width: cellSize.toDouble(),
                    height: cellSize.toDouble(),
                    child: Icon(Icons.face, color: Colors.white),
                  );
                } else if (position == targetPosition) {
                  return Container(
                    color: Colors.green,
                    width: cellSize.toDouble(),
                    height: cellSize.toDouble(),
                    child: Icon(Icons.star, color: Colors.white),
                  );
                } else if (obstacles.contains(position)) {
                  return Container(
                    color: Colors.orange,
                    width: cellSize.toDouble(),
                    height: cellSize.toDouble(),
                  );
                } else {
                  return Container(
                    color: Colors.grey[200],
                    width: cellSize.toDouble(),
                    height: cellSize.toDouble(),
                  );
                }
              },
              itemCount: gridSize * gridSize,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => movePlayer(Point(playerPosition.x, playerPosition.y - 1)), // Up
                  child: Icon(Icons.arrow_upward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 169, 212, 248),  
                ),
              ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => movePlayer(Point(playerPosition.x - 1, playerPosition.y)), // Left
                  child: Icon(Icons.arrow_back),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 169, 212, 248),  
                ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => movePlayer(Point(playerPosition.x + 1, playerPosition.y)), // Right
                  child: Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 169, 212, 248),  
                ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => movePlayer(Point(playerPosition.x, playerPosition.y + 1)), // Down
                  child: Icon(Icons.arrow_downward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 169, 212, 248),  
                ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black),
              ),
              child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: restartGame,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

