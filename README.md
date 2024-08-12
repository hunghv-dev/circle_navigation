A circle navigation bar with a simple animation

<div style="text-align: center;">
  <img src="https://raw.githubusercontent.com/hunghv-dev/circle_navigation/develop/doc/circle_navigation.gif" alt="An animated image of the iOS circle navigation bar UI" />
</div>

## Getting started

To install, add it to your `pubspec.yaml` file:

```
dependencies:
    circle_navigation:
```

To import it:

```dart
import 'package:circle_navigation/circle_navigation.dart';
```

## Usage

Use in bottomNavigationBar property of Scaffold widget:

```dart
@override
Widget build(BuildContext context) =>
    Scaffold(
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
        onChange: (index) =>
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
      ),
    );
```