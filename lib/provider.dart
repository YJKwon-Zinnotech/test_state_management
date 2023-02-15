class ProviderTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>( // Counter에 대한 Provider를 생성했다.
      create: (_) => Counter(),
      child: MaterialApp(
        title: 'Provider Example',
        home: Example(),
      ), // Counter의 숫자를 보여주는 위젯이 들어갈 것이다.
    );
  }
}
class Example extends StatelessWidget {
  Example(){
    print('Example');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Row(
          children:[ Row(
            children: [
              TestWidget('1st Row'),
            ],
          ),
            Row(children:[
              Container(color:Colors.red, child: TestWidget('2nd Row')),
              TextWidget(),
              Text('현재 숫자: ${context.watch<Counter>().count}'),
            ]),]
      ),

    );
  }
}
class Counter extends ChangeNotifier { // ChangeNotifier를 extends한다.

  Counter(){
    secFor(10, 1);
  }
  int _count = 0;

  int get count => _count;

  void secFor(int num, int duration)async{
    for(int i=0; i<num; i++) {
      await Future.delayed(Duration(seconds: duration)).then((_) => increment());
    }
  }


  void increment() {
    _count++;
    notifyListeners();
  }
}

class TestWidget extends StatelessWidget {
  TestWidget(String s, {Key? key}) : super(key: key){
    print('$s Widget has created');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TextWidget extends StatelessWidget {
  TextWidget(){
    print('Text');
  }
  //const TextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('현재 숫자: ${Provider.of<Counter>(context).count}');
  }
}