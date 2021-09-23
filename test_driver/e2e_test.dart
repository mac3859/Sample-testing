// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//import 'package:flutter/material.dart';
//import 'package:flutter_test/flutter_test.dart';

//import 'package:firstapp/main.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byTooltip('increment');
    final buttonAdd = find.byValueKey("add");
    final buttonSubtract = find.byValueKey("subtract");
    final alertText = find.byValueKey("alert_text");
    final btnClose = find.byValueKey("close_button");

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      // First, tap the button.
      await driver.tap(buttonFinder);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(counterTextFinder), "1");

      await driver.tap(buttonFinder);

      expect(await driver.getText(counterTextFinder), "2");
    });

    test("Test with alert window", () async {
      await driver.tap(buttonAdd);
      expect(await driver.getText(alertText), "Times you have pressed: 2");

      await driver.tap(btnClose);

      await driver.tap(buttonSubtract);

      expect(await driver.getText(counterTextFinder), "1");
    });
  });
}
