import 'package:flutter/material.dart';
import 'package:netflix_tmdb_api/screen/splash_scree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Netflix TMDB API',
    );
  }
}