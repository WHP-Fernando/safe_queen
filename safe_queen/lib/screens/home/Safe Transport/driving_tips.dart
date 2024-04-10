import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:safe_queen/screens/home/safe_transport.dart';

void main() {
  runApp(drivingtips());
}

class drivingtips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Scraping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScrapingWidget(),
    );
  }
}

class ScrapingWidget extends StatefulWidget {
  @override
  _ScrapingWidgetState createState() => _ScrapingWidgetState();
}

class _ScrapingWidgetState extends State<ScrapingWidget> {
  // ignore: unused_field
  String _htmlContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Driving Safety',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SafeTransport()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 700, // Set a fixed height for the web view
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(
                  Uri.parse('https://www.arrivealive.mobi/road-safety-for-women-driving-alone').toString(),
                ),
              ),
              onWebViewCreated: (controller) {},
              onLoadStop: (controller, url) async {
                final html = await controller.evaluateJavascript(source: 'document.documentElement.outerHTML');
                setState(() {
                  _htmlContent = html;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

