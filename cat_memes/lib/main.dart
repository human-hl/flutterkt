
import 'package:flutter/material.dart';
import 'features/cat_memes/presentation/pages/memes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Memes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemesPage(),
    );
  }
}
