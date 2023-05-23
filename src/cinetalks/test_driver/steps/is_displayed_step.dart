import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric displayed() {

  return when1<String, FlutterWorld> (
    'There is a {string} displayed in the screen',
        (string, context) async {
        final locator = find.byValueKey(string);
        await FlutterDriverUtils.isPresent(context.world.driver, locator);
    },
  );
}