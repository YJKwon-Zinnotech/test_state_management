import 'package:flutter/material.dart';

class FutureBuild extends StatelessWidget {
  const FutureBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );

  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: fetchPost(),builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData == false){
          return CircularProgressIndicator();
        }
        return Text('test');
      },),
    );
  }
}

Future fetchPost() async{
  await Future.delayed(Duration(seconds: 5));
  var obj =
  {
    "email": 'jhsong@zinnotech.com' ,
    "password": 'password' ,
    "module_name": "zinnoVIEW_pc",
    "ip_address": '192.168.0.1' ,
    "mac_address": '00:00:5e:00:53:af'
  };
  String baseUrl = 'https://test.zinnospace.com/api/login_v2';
  final response = await http.put(Uri.parse(baseUrl), body:obj);

  if (response.statusCode ==200) {
    final respond = await json.decode(response.body);
    return (respond['company_id']);
  }
  else{
    return 'Error';
  }
}
