import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, String>((ref) {
  return Counter();
});

class Counter extends StateNotifier<String> {
  Counter() : super('');

  void increment() {

    state='string1';
  }
  void decrement(){

    state='string2';
  }
  void init(){

    state='string3';
  }
}
void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:MyHomePage());
  }
}


class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterRead = ref.read(counterProvider.notifier);
    final counterState = ref.watch(counterProvider);

    ref.listen(counterProvider, (previous, next) { print('$next change');});
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Center(
        child: Text(
          'Value: $counterState',
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(onPressed: ()=>counterRead.increment()),
            FloatingActionButton(onPressed: ()=>counterRead.decrement()),
            FloatingActionButton(onPressed: ()=>counterRead.init()),
          ],
        ),
      ),
    );
  }
}



