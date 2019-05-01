import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Main Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  List<Widget> _divide(List<Widget> l) {
    for (var i = 1; i < l.length; i += 2) {
      l.insert(i, Divider());

      if (l.length - i <= 2) break;
    }

    return l;
  }

  List<T> _concat<T>(List<T> list, {List<T> addingList, T addingItem}) {
    if (addingList != null) list.addAll(addingList);
    if (addingItem != null) list.add(addingItem);
    
    return list;
  }

  void _dateChanged(DateTime dt) {
    return;
  }

  void _privacyChanged(Privacy p) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(      
      child: CupertinoScrollbar(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              automaticallyImplyLeading: false,
              largeTitle: Text('Nueva Fiesta'),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                _divide([
                  CupertinoTextField(),
                  CupertinoDatePicker(onDateTimeChanged: _dateChanged,),
                  CupertinoSegmentedControl(
                    children: {
                      Privacy.public: Text('Public'),
                      Privacy.inviteOnly: Text('Invite-Only'),
                      Privacy.friends: Text('Friends Only'),
                      Privacy.friendsOfFriends: Text('Friends of Friends'),
                    },
                    onValueChanged: _privacyChanged,
                  )
                ])
              )
            )
          ]
        ),
      ),
    );
  }    
}

enum Privacy {
  public, inviteOnly, friends, friendsOfFriends
}