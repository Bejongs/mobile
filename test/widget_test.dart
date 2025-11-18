import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build a minimal test app containing a counter.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: _CounterTestWidget(),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and rebuild.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the counter incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// Small local counter widget used only for tests.
class _CounterTestWidget extends StatefulWidget {
  @override
  State<_CounterTestWidget> createState() => _CounterTestWidgetState();
}

class _CounterTestWidgetState extends State<_CounterTestWidget> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_count'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() => _count++),
        ),
      ],
    );
  }
}
