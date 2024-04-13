import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatelessWidget {
  final YoutubePlayerController controller;

  const VideoPlayerPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,  
        title: Text('Video Player',
        style: TextStyle(
            fontWeight: FontWeight.bold,      
          ),
          ),
          centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252),  
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
