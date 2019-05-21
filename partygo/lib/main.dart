import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Main Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Privacy _partyPrivacy = Privacy.public;

  Widget _rowSpacer() => Padding(padding: EdgeInsets.only(top: 30));

  List<Widget> _privacyRadios() {
    return [ 
      [Privacy.public, 'Public'],
      [Privacy.inviteOnly, 'Invite Only'],
      [Privacy.friends, 'Friends Only'],
      [Privacy.friendsOfFriends, 'Friends of Friends']
    ].map((x) {
      return Expanded(
        child: Column(
          children: [
            Radio(value: x[0], groupValue: _partyPrivacy, onChanged: (x) {
              setState(() {
                _partyPrivacy = x;
              });
            }),
            Text(x[1], textAlign: TextAlign.center)
          ]
        )
      );
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Fiesta'), centerTitle: true, backgroundColor: Colors.purple,),
      body: Center(
        child: Padding(padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Form(
            child: ListView(
              children: [
                TextFormField(decoration: InputDecoration(hintText: 'Título')),
                LocationTextField(child: TextFormField(decoration: InputDecoration(hintText: 'Ubicación'))),
                _rowSpacer(),
                TextFormField(minLines: 5, maxLines: 5, decoration: InputDecoration(hintText: 'Descripción')),
                _rowSpacer(),
                TextFormField(decoration: InputDecoration(hintText: 'Disponibilidad')),
                Row(children: _privacyRadios(), crossAxisAlignment: CrossAxisAlignment.start,),

              ]
            ),
          ),
        ),
      ),
    );
  }      
}

class LocationTextField extends StatefulWidget {
  final Widget child;

  LocationTextField({this.child});

  @override
  State<StatefulWidget> createState() => LocationTextFieldState();    
}

class LocationTextFieldState extends State<LocationTextField> {
  Location _location;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class Location {
  double latitude;
  double longitude;
}

enum Privacy {
  public, inviteOnly, friends, friendsOfFriends
}