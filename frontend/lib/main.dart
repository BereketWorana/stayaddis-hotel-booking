import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StayAddisApp());
}

class StayAddisApp extends StatelessWidget {
  const StayAddisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayAddis',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}