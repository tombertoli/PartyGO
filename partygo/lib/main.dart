import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyGO',
      home: CreatePartyPage(title: 'Crear Fiesta'),
      routes: {
        '/create_party': (context) => CreatePartyPage(title: 'Crear Fiesta')
      },
      theme: ThemeData(primaryColor: Colors.purple)
    );
  }
}

class CreatePartyPage extends StatefulWidget {
  CreatePartyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreatePartyPageState createState() => _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  Privacy _partyPrivacy = Privacy.public;
  DateTime _partyDate = DateTime.now().add(Duration(hours: 1));

  Widget _rowSpacer() => Padding(padding: EdgeInsets.only(top: 30));
  String locale;
  bool _isInitialized = false;

  List<Widget> _privacyRadios() => [ 
    [Privacy.public, 'Public'],
    [Privacy.inviteOnly, 'Invite Only'],
    [Privacy.friends, 'Friends Only'],
    [Privacy.friendsOfFriends, 'Friends of Friends']
  ].map((x) {
    return Expanded(
      child: ColumnAreaRadio(
        children: [
            Radio(
              value: x[0], groupValue: _partyPrivacy, 
              onChanged: (x) {
              setState(() => _partyPrivacy = x);
            }),
            Text(x[1], textAlign: TextAlign.center)
        ])
    );
  }).toList(growable: false);
  

  void _showDatePicker(BuildContext context) {
    DatePicker.showDateTimePicker(context,
      currentTime: _partyDate,
      onConfirm: (dt) {
        setState(() => _partyDate = dt);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      _isInitialized = true;

      final tempcale = Localizations.localeOf(context);
      locale = tempcale.languageCode + '_' + tempcale.countryCode;
      
      initializeDateFormatting(locale, null);
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.save_alt)),
      body: Center(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            child: ListView(
              children: [
                Padding(padding: EdgeInsets.only(top: 25), child: TextField(decoration: InputDecoration(labelText: 'Título'))),
                LocationTextField(child: TextFormField(decoration: InputDecoration(labelText: 'Ubicación'))),
                _rowSpacer(),

                TextFormField(minLines: 5, maxLines: 5, decoration: InputDecoration(labelText: 'Descripción'), textInputAction: TextInputAction.done,),
                _rowSpacer(),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _showDatePicker(context),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Fecha', style: Theme.of(context).textTheme.subhead),
                    Text(DateFormat.yMMMd(locale).format(_partyDate) + ' ' + DateFormat('h:mm a', locale).format(_partyDate),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.subhead.merge(TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.grey))
                    )
                  ]),
                ),
                _rowSpacer(),

                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 20), child: TextField(keyboardType: TextInputType.number, maxLength: 4, decoration: InputDecoration(labelText: 'Disponibilidad')))),
                  Expanded(child: TextField(keyboardType: TextInputType.number, maxLength: 2, decoration: InputDecoration(labelText: 'Edad Mínima')))
                ]),
                Row(children: _privacyRadios(), crossAxisAlignment: CrossAxisAlignment.start,),
                _rowSpacer(),
              ]
            ),
          ),
        ),
      ),
    );
  }      
}

class ColumnAreaRadio extends StatelessWidget {
  final List<Widget> children;

  ColumnAreaRadio({this.children});

  @override
  Widget build(BuildContext context) {
    var radios = children.where((x) { return x is Radio; }).toList();
    
    if (radios.length != 1) {
      throw FormatException('You need to provide exactly 1 radio.');
    }

    Radio radio = radios.first;

    return GestureDetector(
      onTap: () => radio.onChanged(radio.value),
      child: Column(children: children)
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