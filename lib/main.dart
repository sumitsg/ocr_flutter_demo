// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:ocr_flutter_demo/widget/text_recognition_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String title = 'OCR Flutter';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(
        title: title,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;
  const MainPage({Key? key, required this.title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            SizedBox(
              height: 25,
            ),
            TextRecognitionWidget(),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
