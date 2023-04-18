import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenPage extends Given1WithWorld<String, FlutterWorld> {
  GivenPage()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String page) async {
    final locator = find.byValueKey(page);
    await FlutterDriverUtils.isPresent(world.driver, locator);
  }

  @override
  RegExp get pattern => RegExp(r"I am in the {string} page");
}

class ThenPage extends Then1WithWorld<String, FlutterWorld> {
  ThenPage()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String page) async {
    final locator = find.byValueKey(page);
    await FlutterDriverUtils.isPresent(world.driver, locator);
  }

  @override
  RegExp get pattern => RegExp(r"I should be on the {string} page");
}
