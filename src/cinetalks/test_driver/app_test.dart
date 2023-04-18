import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/then_tap_ button.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = []
    ..customStepParameterDefinitions = [] // colocar aqui os custom steps
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  return GherkinRunner().execute(config);
}
