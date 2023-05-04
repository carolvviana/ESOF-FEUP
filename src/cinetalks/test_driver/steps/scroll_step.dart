import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';
// import 'package:cinetalks/test_driver/utils/flutter_driver_utils.dart'

// StepDefinitionGeneric WhenScroll() {
//   return when1<String, FlutterWorld>(
//     RegExp(r"I scroll {string}"),
//     (direction, context) async {
//       final dy = direction == 'string' ? 100.0 : -100.0;
//       final scrollableFinder = find.byType(Scrollable);
//     },
//   );
// }

class FlutterWorld extends World {
  final FlutterDriver driver;
  FlutterWorld(this.driver);
}

extension FlutterDriverUtils on FlutterDriver {
  FlutterWorld get world => FlutterWorld(this);
}

StepDefinitionGeneric whenScroll() {
  return when1<String, FlutterWorld>(
    RegExp(r"I scroll (up|down)"),
    (direction, context) async {
      final scrollDirection = direction == 'up' ? -1 : 1;
      // final driver = FlutterDriverUtils.getDriver(context);
      final driver = context.world.driver;
      await driver.scroll(
        find.byType('Page'),
        0.0,
        scrollDirection * 500,
        Duration(milliseconds: 500),
      );
    },
  );
}





// StepDefinitionGeneric whenScroll() {
//   return when1<int, String, FlutterWorld>(
//     RegExp(r"I scroll (\d+) pixels (down|up)"),
//     (pixels, direction, context) async {
//       final scrollableFinder = find.byType(Scrollable);
//       final scrollOffset = direction == 'down' ? pixels : -pixels;
//       await context.world.driver.scroll(
//         scrollableFinder, 
//         0, 
//         scrollOffset, 
//         const Duration(milliseconds: 300),
//       );
//     },
//   );
// }

// StepDefinitionGeneric WhenScroll() {
//   return when2('I scroll {string}', (List<String> args) async {
//     final direction = args[0];
//     final dy = direction == 'down' ? 100.0 : -100.0;
//     final scrollableFinder = find.byType('ListView'); // replace with the actual scrollable widget finder
//     final scrollable = await driver.waitFor(scrollableFinder);
//     await driver.scroll(
//       scrollable,
//       0.0,
//       dy,
//       const Duration(milliseconds: 300),
//     );
//   });
// }






// StepDefinitionGeneric whenScrollDown() {
//   return when<String, FlutterWorld>(
//     RegExp(r'I scroll down'),
//     (direction, context) async {
//       final finder = find.descendant(
//         of: find.byType(Scrollable),
//         matching: find.byType(Scrollable),
//       );
//       final scrollable = await FlutterDriverUtils.getWidgetPropertyValue<Scrollable>(
//         context.world.driver, finder, 'widget');
//       final currentPosition = await FlutterDriverUtils.getWidgetPropertyValue<double>(
//         context.world.driver, finder, 'scrollOffset');
//       final scrollDelta = 100.0; // Set your own scroll delta here
//       final newPosition = currentPosition + scrollDelta;
//       await context.world.driver.scroll(
//         finder, 0, -scrollDelta, Duration(milliseconds: 500));
//       await Future.delayed(Duration(milliseconds: 500)); // Wait for the scroll animation to complete
//     },
//   );
// }

// StepDefinitionGeneric<World> whenScrollDown() {
//   return when<void>(
//     RegExp(r'I scroll down'),
//     (context) async {
//       await FlutterDriverUtils.scroll(
//         context.world.driver,
//         find.byType('ListView'),
//         const Offset(0, -300),
//       );
//     },
//   );
// }



