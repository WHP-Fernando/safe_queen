import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityChat extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community Chat',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 253, 238, 252),
        centerTitle: true,
        titleSpacing: 0.0,
        actions: [],
      ),
      backgroundColor: Color.fromARGB(255, 253, 238, 252),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('timestamp',
                      isGreaterThanOrEqualTo: DateTime.now()
                          .subtract(Duration(days: 1)))
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data();
                    bool isCurrentUser = message['sender'] ==
                        FirebaseAuth.instance.currentUser?.email;
                    return GestureDetector(
                      onLongPress: () {
                        if (isCurrentUser) {
                          _confirmDeleteMessage(context, messages[index].id);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: isCurrentUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isCurrentUser)
                              // Avatar display it's not the current user's message
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  message['sender'][0].toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isCurrentUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['sender'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Container(
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: isCurrentUser
                                          ? Colors.grey[300]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (message['imageUrl'] != null)
                                          Image.network(
                                            message['imageUrl'],
                                            width: 150,
                                          )
                                        else
                                          Linkify(
                                            onOpen: (link) => _openLink(link),
                                            text: message['text'],
                                            linkStyle: TextStyle(
                                              color: _isGoodLink(message['text']) ? Colors.green : Colors.red,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          _formatTimestamp(message['timestamp']),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(
                                                0.5), // Low brightness color
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 8.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera_alt, size: 24),
                              onPressed: () {
                                _getImageAndSendMessage(context, ImageSource.camera);
                              },
                            ),
                            SizedBox(width: 8.0),
                            IconButton(
                              icon: Icon(Icons.photo_library, size: 24),
                              onPressed: () {
                                _getImageAndSendMessage(context, ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Send'),
                  onPressed: () {
                    _sendMessage(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = '${dateTime.hour}:${dateTime.minute}';
    return formattedTime;
  }

  void _sendMessage(BuildContext context) {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      // Check if message contains bad words
      if (!containsBadWords(messageText)) {
        String sender =
        FirebaseAuth.instance.currentUser?.email ?? 'Anonymous';
        FirebaseFirestore.instance.collection('messages').add({
          'text': messageText,
          'sender': sender,
          'timestamp': Timestamp.now(),
        });
        _messageController.clear();
      } else {
        // Show alert dialog notifying the sender about bad words
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Message Contains Bad Words'),
              content: Text(
                  'Your message cannot be sent because it contains inappropriate content.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _getImageAndSendMessage(BuildContext context, ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String sender =
          FirebaseAuth.instance.currentUser?.email ?? 'Anonymous';
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("chat_images/${DateTime.now().millisecondsSinceEpoch}");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection('messages').add({
        'imageUrl': imageUrl,
        'sender': sender,
        'timestamp': Timestamp.now(),
      });
    }
  }

  void _deleteMessage(String messageId) {
    FirebaseFirestore.instance.collection('messages').doc(messageId).delete();
  }

  void _confirmDeleteMessage(BuildContext context, String messageId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Message?'),
          content: Text('Are you sure you want to delete this message?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteMessage(messageId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _openLink(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch ${link.url}';
    }
  }

  bool containsBadWords(String message) {
    List<String> badWords = [
      'shit','slut','bitch','cunt','slag','hussy','tart','floozy','baggage', 'fuck', 'arse', 'bullshit', 'pissed', 'lizards', 'bloody', 'bastard', 'motherfucker', 'damn', 'bugger', 'shut', 'sexy', 'sex', 'fuck you', 'go to the hell', 'go to hell', 'son of bitch', 'chick','pussy','shemale','lesboan','lesbi','asshole',
      'dame', 'moll', 'doxy', 'bimbo', 'bitch', 'බැල්ලි', 'ඌ', 'මූ', 'අරූ', 'උබ', 'වරෙන්', 'පලයන්', '​තෝ','පල','ගෑණී','උබට',
    ]; // List of bad words
    for (String word in badWords) {
      if (message.toLowerCase().contains(word)) {
        return true;
      }
    }
    return false;
  }

 
bool _isGoodLink(String text) {
  // Check if the text starts with http:// or https://
  if (text.toLowerCase().startsWith('http://') ||
      text.toLowerCase().startsWith('https://')) {
    // Extract the domain from the URL
    String domain = _extractDomain(text);
    
    // List of reputable domains that you recognize
    List<String> reputableDomains = [
       'wikipedia.org','google.com','facebook.com','twitter.com','instagram.com','youtube.com','amazon.com','microsoft.com','apple.com','cnn.com','bbc.com','nytimes.com','forbes.com','bloomberg.com','economist.com','nationalgeographic.com','reuters.com','nasa.gov','whitehouse.gov','un.org','gov.lk ','ac.lk','lk','slt.lk  ','mobitel.lk  ','sampath.lk ','commercialbank.lk  ','hnb.lk  ','peoplesbank.lk  ','cbsl.gov.lk  ','health.gov.lk  ','slbfe.lk ','education.gov.lk ','ceylonchamber.lk' ,'slida.lk ',
        
    ];
    
    // Check if the domain or its variation with "www" is in the list of reputable domains
    if (reputableDomains.any((reputableDomain) => 
        domain.contains(reputableDomain) || domain.contains('www.$reputableDomain'))) {
      return true;
    } else {
      return false;
    }
  } else {
    // Links without http:// or https:// are considered suspicious
    return false;
  }
}

String _extractDomain(String url) {
  Uri uri = Uri.parse(url);
  return uri.host;
}


}
