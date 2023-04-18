import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

// class GivenPage extends Given1WithWorld<String, FlutterWorld> {
//   GivenPage()
//       : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

//   @override
//   Future<void> executeStep(String page) async {
//     final locator = find.byValueKey(page);
//     await FlutterDriverUtils.isPresent(world.driver, locator);
//   }

//   @override
//   RegExp get pattern => RegExp(r"I am in the {string} page");
// }

StepDefinitionGeneric GivenPage() {
  return given1<String, FlutterWorld>(
    RegExp(r"I am in the {string} page"),
    (page, context) async {
      final locator = find.byValueKey(page);
      await FlutterDriverUtils.isPresent(context.world.driver, locator);
    },
  );
}

// class ThenPage extends Then1WithWorld<String, FlutterWorld> {
//   ThenPage()
//       : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

//   @override
//   Future<void> executeStep(String page) async {
//     final locator = find.byValueKey(page);
//     await FlutterDriverUtils.isPresent(world.driver, locator);
//   }

//   @override
//   RegExp get pattern => RegExp(r"I should be on the {string} page");
// }

StepDefinitionGeneric ThenPage() {
  return then1<String, FlutterWorld>(
    RegExp(r"I should be on the {string} page"),
    (page, context) async {
      final locator = find.byValueKey(page);
      await FlutterDriverUtils.isPresent(context.world.driver, locator);
    },
  );
}
