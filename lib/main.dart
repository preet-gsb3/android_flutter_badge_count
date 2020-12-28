import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

const CHANNEL = "com.example.android_bridger.channel";
const SET_BADGE_KEY_NATIVE = "IncreaseBadge";
const REMOVE_BADGE_KEY_NATIVE = "RemoveBadge";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "0";
  static const platform = const MethodChannel(CHANNEL);

  @override
  initState() {
    super.initState();

    _removeBadge();
  }

  Future<void> _addBadge() async {
    await platform.invokeMethod(SET_BADGE_KEY_NATIVE).then((value) {
      setState(() {
        _counter = value;
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> _removeBadge() async {
    await platform.invokeMethod(REMOVE_BADGE_KEY_NATIVE).then((value) {
      setState(() {
        _counter = value;
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('$_counter'),
          new RaisedButton(
            child: new Text('Add badge'),
            onPressed: () {
              _addBadge();
            },
          ),
          new RaisedButton(
              child: new Text('Remove badge'),
              onPressed: () {
                _removeBadge();
              }),
        ],
      ),
    );
  }
}
