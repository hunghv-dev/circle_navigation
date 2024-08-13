import 'package:circle_navigation/circle_navigation.dart';
import 'package:circle_navigation/src/background/background.dart';
import 'package:circle_navigation/src/item/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension on WidgetTester {
  Future<void> build(CircleNavigation navigation) => pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: navigation,
          ),
        ),
      );
}

void main() {
  /// selectedIndex for verify the tap trigger
  int? selectedIndex;

  /// Define the list of items
  final items = [
    Item(icon: const Icon(Icons.home), label: 'Home'),
    Item(icon: const Icon(Icons.account_circle), label: 'User'),
    Item(icon: const Icon(Icons.settings), label: 'Settings'),
  ];

  /// Define a mock onChange callback
  void onChange(int index) => selectedIndex = index;

  setUp(() => selectedIndex = null);

  testWidgets(
      'Size => height: 100 & circleWidth: 80 & circleMargin: 5 -> navHeight: 145 & navWidth: screenWidth',
      (tester) async {
    await tester.build(CircleNavigation(
      items: items,
      onChange: onChange,
      height: 100.0,
      circleWidth: 80.0,
      circleMargin: 5.0,
    ));
    // Verify the size of the CircleNavigation widget
    final circleNavSize = tester.getSize(find.byType(CircleNavigation));
    final screenSize = tester.getSize(find.byType(Scaffold));
    expect(circleNavSize.height, 145);
    expect(circleNavSize.width, screenSize.width);
  });

  testWidgets(
      'Layout => items: 3 & itemSpacing: 10 -> CircleNavigation: 1 & Background: 1 & NavItem: 3',
      (tester) async {
    await tester.build(CircleNavigation(
      items: items,
      onChange: onChange,
      trim: 10,
    ));
    // Verify the layout of the widget
    expect(find.byType(CircleNavigation), findsOneWidget);
    expect(find.byType(Background), findsOneWidget);
    expect(find.byType(NavItem), findsNWidgets(3));
  });

  testWidgets('InitIndex => initIndex: 1 -> secondNavItem.selected: true',
      (tester) async {
    // initIndex set to 1
    await tester.build(CircleNavigation(
      initIndex: 1,
      items: items,
      onChange: onChange,
    ));
    final secondNavItem = tester.widget<NavItem>(find.byType(NavItem).at(1));
    // Verify the secondNavItem is selected
    expect(secondNavItem.selected, true);
  });

  testWidgets('OnChange => tap Icons.settings(index: 2) -> selectedIndex: 2',
      (tester) async {
    await tester.build(CircleNavigation(
      items: items,
      onChange: onChange,
    ));
    // Tap on the third item
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    // Verify the onChange callback is called with the correct index
    expect(selectedIndex, 2);
  });
}
