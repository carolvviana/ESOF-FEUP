import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric thenTapButton() {
  return then1<String, FlutterWorld>(
    'I tap the {string} button',
    (key, context) async {
      final button = find.byValueKey(key);
      await FlutterDriverUtils.tap(context.world.driver, button);
    },

    // (key, context) async {
    //   final locator = find.byValueKey(key);
    //   final buttonList = await context.world.driver
    //       ?.getWidgetDiagnostics(locator, subtreeDepth: 1);

    //   await FlutterDriverUtils.tap(
    //       context.world.driver, buttonList?.entries.first);


      // if (buttonList.isNotEmpty) {
      //   final firstButton = buttonList.first;
      //   await context.world.driver.tap(firstButton);
      // } else {
      //   throw Exception('No button with key $key found');
      // }
    // },
  );
}
