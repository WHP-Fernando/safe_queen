import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' show Document;

void main() {
  runApp(MaterialApp(
    home: MyWebExtractorApp(),
  ));
}

class MyWebExtractorApp extends StatefulWidget {
  @override
  _MyWebExtractorAppState createState() => _MyWebExtractorAppState();
}

class _MyWebExtractorAppState extends State<MyWebExtractorApp> {
  late Future<Document?> _htmlContent;

  @override
  void initState() {
    super.initState();
    _htmlContent = fetchAndParseHTMLContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Provisions',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
      ),
      ),
       centerTitle: true,
        backgroundColor: Colors.yellow, // Change app bar color to yellow
      ),
       backgroundColor: Color.fromARGB(255, 253, 238, 252), 
      body: FutureBuilder<Document?>(
        future: _htmlContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data != null) {
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: extractData(snapshot.data!),
              );
            } else {
              return Center(child: Text('No data available.'));
            }
          }
        },
      ),
    );
  }
}

Future<Document?> fetchAndParseHTMLContent() async {
  final response = await http.get(Uri.parse(
      'https://resourcehub.bakermckenzie.com/en/resources/fighting-domestic-violence/asia/sri-lanka/topics/1legal-provisions'));
  if (response.statusCode == 200) {
    return parse(response.body);
  } else if (response.statusCode == 403) {
    print('Access to the resource is forbidden (403)');
    return null;
  } else {
    print('Failed to load HTML content: ${response.statusCode}');
    return null;
  }
}

List<Widget> extractData(Document document) {
  final paragraphs = document.getElementsByTagName('p');
  List<Widget> paragraphWidgets = [];
  for (var p in paragraphs) {
    paragraphWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          p.text,
          style: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
    );
  }
  return paragraphWidgets;
}
