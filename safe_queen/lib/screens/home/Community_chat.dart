import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Add this import

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
        centerTitle: true,
        titleSpacing: 0.0,
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
          //filter and show only messages within 1 day
                  .where('timestamp', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
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
                    bool isCurrentUser =
                        message['sender'] == FirebaseAuth.instance.currentUser?.email;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: isCurrentUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isCurrentUser) // Show avatar if it's not the current user's message
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
                              crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                                    color: isCurrentUser ? Colors.grey[300] : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      message['imageUrl'] != null
                                          ? Image.network(
                                              message['imageUrl'],
                                              width: 150,
                                            )
                                          : Text(
                                              message['text'],
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        _formatTimestamp(message['timestamp']),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5), // Low brightness color
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
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    _getImageAndSendMessage();
                  },
                  child: Icon(
                    Icons.image,
                    color: Colors.blue,
                ),
                ),
                SizedBox(width: 8.0),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Send'),
                  onPressed: () {
                    _sendMessage();
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

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      String sender = FirebaseAuth.instance.currentUser?.email ?? 'Anonymous';
      FirebaseFirestore.instance.collection('messages').add({
        'text': messageText,
        'sender': sender,
        'timestamp': Timestamp.now(),
      });
      _messageController.clear();
    }
  }

  void _getImageAndSendMessage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery); // Change getImage to pickImage
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String sender = FirebaseAuth.instance.currentUser?.email ?? 'Anonymous';
      Reference ref = FirebaseStorage.instance.ref().child("chat_images/${DateTime.now().millisecondsSinceEpoch}");
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
}
