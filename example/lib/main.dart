import 'package:circle_navigation/circle_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [

        ],
      ),
      bottomNavigationBar: CircleNavigation(
        items: [
          Item(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
              label: 'Home'),
          Item(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 30,
              ),
              label: 'User'),
          Item(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              label: 'Settings'),
        ],
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        circleColor: Colors.green,
        navColor: Colors.lightBlue,
        onChange: (_) {},
      ),
    );
  }
}
