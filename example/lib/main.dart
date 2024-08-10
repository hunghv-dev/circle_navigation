import 'package:circle_navigation/circle_navigation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int initIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    initIndex = 0;
    pageController = PageController(initialPage: initIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Icon(Icons.home, color: Colors.green, size: 150),
            Icon(Icons.account_circle, color: Colors.green, size: 150),
            Icon(Icons.settings, color: Colors.green, size: 150),
          ],
        ),
        bottomNavigationBar: CircleNavigation(
          initIndex: initIndex,
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
          navColor: Colors.blue,
          onChange: (index) => pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
        ),
      );
}
