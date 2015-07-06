import 'dart:html';
import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';

class HtmlEmitter implements ScoreEmitter {
  final TableElement _table;

  HtmlEmitter() : _table = new TableElement() {
    _table.createTHead().addRow()
      ..addCell().text = 'Test'
      ..addCell().text = 'Runtime';

    document.body.append(_table);
  }

  void emit(String testName, double value) {
    _table.addRow()
      ..addCell().text = testName
      ..addCell().text = '${value.toStringAsPrecision(5)} μs';
  }

  void addDivider() {
    _table.addRow().className = 'divider';
  }
}

class ReactListOneChild extends BenchmarkBase {
  const ReactListOneChild({ScoreEmitter emitter}) : super('React children as list: 1 child', emitter: emitter);
  void run() {
    react.div({}, [
      react.div({}, '1')
    ]);
  }
}
class ReactVariadicOneChild extends BenchmarkBase {
  const ReactVariadicOneChild({ScoreEmitter emitter}) : super('React children as variadic: 1 child', emitter: emitter);
  void run() {
    react.div({},
      react.div({}, '1')
    );
  }
}

class ReactListTwoChildren extends BenchmarkBase {
  const ReactListTwoChildren({ScoreEmitter emitter}) : super('React children as list: 2 children', emitter: emitter);
  void run() {
    react.div({}, [
      react.div({}, '1'),
      react.div({}, '2')
    ]);
  }
}
class ReactVariadicTwoChildren extends BenchmarkBase {
  const ReactVariadicTwoChildren({ScoreEmitter emitter}) : super('React children as variadic: 2 children', emitter: emitter);
  void run() {
    react.div({},
      react.div({}, '1'),
      react.div({}, '2')
    );
  }
}


class ReactListThreeChildren extends BenchmarkBase {
  const ReactListThreeChildren({ScoreEmitter emitter}) : super('React children as list: 3 children', emitter: emitter);
  void run() {
    react.div({}, [
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3')
    ]);
  }
}
class ReactVariadicThreeChildren extends BenchmarkBase {
  const ReactVariadicThreeChildren({ScoreEmitter emitter}) : super('React children as variadic: 3 children', emitter: emitter);
  void run() {
    react.div({},
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3')
    );
  }
}


class ReactListFourChildren extends BenchmarkBase {
  const ReactListFourChildren({ScoreEmitter emitter}) : super('React children as list: 4 children', emitter: emitter);
  void run() {
    react.div({}, [
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3'),
      react.div({}, '4')
    ]);
  }
}
class ReactVariadicFourChildren extends BenchmarkBase {
  const ReactVariadicFourChildren({ScoreEmitter emitter}) : super('React children as variadic: 4 children', emitter: emitter);
  void run() {
    react.div({},
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3'),
      react.div({}, '4')
    );
  }
}

// Main function runs the benchmark.
main() async {
  String headingText;

  if (const String.fromEnvironment('PROD') == 'true') {
    headingText = 'React element construction performance benchmark (dart2js)';
  } else {
    headingText = 'React element construction performance benchmark (Dart VM)';

    window.alert(
        'Not running in PROD (dart2js) mode.\n\n'
        'The following benchmark run reflects Dart VM performance, NOT dart2js performance.\n\n'
        'Run this benchmark in another browser for more useful results.'
    );
  }

  document.body.children.insert(0, new HeadingElement.h1()..text = headingText);

  setClientConfiguration();
  var emitter = new HtmlEmitter();

  emitter.addDivider();

  await new ReactListOneChild(emitter: emitter).report();
  await new ReactVariadicOneChild(emitter: emitter).report();

  emitter.addDivider();

  await new ReactListTwoChildren(emitter: emitter).report();
  await new ReactVariadicTwoChildren(emitter: emitter).report();

  emitter.addDivider();

  await new ReactListThreeChildren(emitter: emitter).report();
  await new ReactVariadicThreeChildren(emitter: emitter).report();

  emitter.addDivider();

  await new ReactListFourChildren(emitter: emitter).report();
  await new ReactVariadicFourChildren(emitter: emitter).report();
}
