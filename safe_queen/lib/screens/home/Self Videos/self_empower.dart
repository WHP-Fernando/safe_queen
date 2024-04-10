import 'package:flutter/material.dart';
import 'package:safe_queen/screens/home/Self%20Videos/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SelfEmpowermentPage extends StatelessWidget {
  // List of video data
  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Inspirational speech by Senela (CEO - Women Empowered Global)',
      'videoId': 'OfiUorZC7Vo',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.52.33.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'OfiUorZC7Vo',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
     {
      'title': 'Best Motivational Video Ever | Every Woman Needs To See This',
      'videoId': '5DtDJABXkIo',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.55.56.png',
      'controller': YoutubePlayerController(
        initialVideoId: '5DtDJABXkIo',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
    {
      'title': '5 Best Ads to Empower Womens | WHY & WHAT',
      'videoId': '5h238RcVUxc',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.57.48.png',
      'controller': YoutubePlayerController(
        initialVideoId: '5h238RcVUxc',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
    {
      'title': 'I Am Her: Empowering Women Through Entrepreneurship',
      'videoId': 'Bk2C047I4X8',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 08.39.57.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'Bk2C047I4X8',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
      {
      'title': 'Speech on Women Empowerment for Students',
      'videoId': 'Tlz_v7b-uis',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.26.16.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'Tlz_v7b-uis',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
     {
      'title': 'Angela bassett empowering speech for women. every woman should hear this !',
      'videoId': 'F37Sr98uA7I',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 13.08.25.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'F37Sr98uA7I',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    }, 
     {
      'title': 'කාන්තාව හා දියණියගේ ආරක්ෂාව I Mr. J.A.P. Siddhisena ',
      'videoId': 'u-De1BAm8HA',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.11.18.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'u-De1BAm8HA',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    }, 
    {
      'title': 'Piyum Vila | ළමා හා කාන්තා වට නීතියේ ඇති ආරක්ෂාව ගැන ඔබ දැනුවත් ද ? ',
      'videoId': '4WJJablfVtg',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.17.20.png',
      'controller': YoutubePlayerController(
        initialVideoId: '4WJJablfVtg',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    }, 
    {
      'title': 'අර්බුදයන්ට මුහුණ දෙන කාන්තාවන් සවිබල ගැන්වීම. ',
      'videoId': 'koSI3dseN6k',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.18.45.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'koSI3dseN6k',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
    {
      'title': 'Nugasewana - කාන්තාව සවිබල ගැන්වීම',
      'videoId': 'hukNBJLqyIs',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 12.22.32.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'hukNBJLqyIs',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
    {
      'title': '“Dear Young Woman”: a poem of empowerment',
      'videoId': 'adUToRtRkaY',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 13.10.08.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'adUToRtRkaY',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    },
     {
      'title': '25 Safety Tips For Women',
      'videoId': 'MF7reW-hkJE',
      'imagePath': 'assets/images/Screenshot 2024-04-07 at 13.03.39.png',
      'controller': YoutubePlayerController(
        initialVideoId: 'MF7reW-hkJE',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    }, // Add more videos  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent, // app bar color
        title: Text(
          'Self Empowerment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252), // background color
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _playVideo(context, videos[index]['controller']);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videos[index]['title'] ?? 'Video Title',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        AspectRatio(
                          aspectRatio: 16 / 9, // Aspect ratio of YouTube videos
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Stack(
                              children: [
                                Image.asset(
                                  videos[index]['imagePath'],
                                  fit: BoxFit.cover,
                                ),
                                Center(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _openYouTubeLink(videos.last['videoId']);
            },
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // button background color  
            ),
            child: Text("Watch more on YouTube",
            style: TextStyle(color: Colors.white), // text color  
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Function to play the YouTube video
  void _playVideo(BuildContext context, YoutubePlayerController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(controller: controller),
      ),
    );
  }

  // Function to open the YouTube link in the default browser
  void _openYouTubeLink(String videoId) async {
    String url = 'https://www.youtube.com/watch?v=$videoId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
