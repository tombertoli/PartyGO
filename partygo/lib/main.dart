import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyGO',
      home: CreatePartyPage(title: 'Crear Fiesta'),
      routes: {
        '/create_party': (context) => CreatePartyPage(title: 'Crear Fiesta'),
        '/create_party/details': (context) => CreatePartyDetailsPage(title: 'Detalles'),
        '/create_party/privacy': (context) => CreatePartyPrivacyPage(title: 'Privacidad'),
        '/create_party/availability': (context) => CreatePartyAvailabilityPage(title: 'Disponibilidad'),
        '/create_party/description': (context) => CreatePartyDescriptionPage(title: 'Info Adicional'),
      },
      theme: ThemeData(primaryColor: Colors.purple)
    );
  }
}

class CreatePartyDescriptionPage extends StatefulWidget {
  final String title;

  CreatePartyDescriptionPage({this.title});

  @override
  State<CreatePartyDescriptionPage> createState() => _CreatePartyDescriptionPageState();
}

class _CreatePartyDescriptionPageState extends State<CreatePartyDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return CreatePartyScaffold(
      title: widget.title,
      body: Column(
        children: [
          Text('Algo más que les quieras decir a tus fiesteros?', style: TextStyle(fontSize: 20)),
          TextFormField(minLines: 5, maxLines: 5, decoration: InputDecoration(hintText: 'e.g.q Escabio cada 2!'), textInputAction: TextInputAction.done,),
        ]
      ),
    );
  }
}

class CreatePartyAvailabilityPage extends StatefulWidget {
  final String title;

  CreatePartyAvailabilityPage({this.title});

  @override
  State<CreatePartyAvailabilityPage> createState() => _CreatePartyAvailabilityPageState();
}

class _CreatePartyAvailabilityPageState extends State<CreatePartyAvailabilityPage> {
  @override
  Widget build(BuildContext context) {
    return CreatePartyScaffold(
      title: widget.title, 
      nextPage: '/create_party/description',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cuantos entran?', style: TextStyle(fontSize: 20)),
          TextField(keyboardType: TextInputType.number, maxLength: 4, decoration: InputDecoration(hintText: 'De 1 a 9999'))
        ]
      )
    );
  }
}

class CreatePartyPrivacyPage extends StatefulWidget {
  final String title;

  CreatePartyPrivacyPage({this.title});

  @override
  State<CreatePartyPrivacyPage> createState() => _CreatePartyPrivacyPageState();
}

class _CreatePartyPrivacyPageState extends State<CreatePartyPrivacyPage> {
  Privacy _partyPrivacy = Privacy.public;

  List<Widget> _privacyRadios() => [ 
    [Privacy.public, 'Todos los que usan PartyGO'],
    [Privacy.inviteOnly, 'Solo los que tienen una invitacion'],
    [Privacy.friends, 'Todos mis amigos'],
    [Privacy.friendsOfFriends, 'Mis amigos y sus amigos']
  ].map((x) {
    return RowAreaRadio(
      children: [
        Radio(
          value: x[0], groupValue: _partyPrivacy, 
          onChanged: (x) => setState(() => _partyPrivacy = x)
        ),
        Text(x[1], style: TextStyle(fontSize: 16))
      ]
    );
  }).toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return CreatePartyScaffold(
      title: widget.title, 
      nextPage: '/create_party/availability',
      body: Column(children: [
        Text('Quienes pueden entrar a tu fiesta?', style: TextStyle(fontSize: 20)),
        Padding(padding: EdgeInsets.only(bottom: 20),),
        Column(children: _privacyRadios(), crossAxisAlignment: CrossAxisAlignment.start,),
      ], crossAxisAlignment: CrossAxisAlignment.start,)   
    );
  }
}

class CreatePartyDetailsPage extends StatefulWidget {
  final String title;

  CreatePartyDetailsPage({this.title});

  @override
  State<StatefulWidget> createState() => _CreatePartyDetailsPageState();
}

class _CreatePartyDetailsPageState extends State<CreatePartyDetailsPage> {
  DateTime _partyDate = DateTime.now().add(Duration(hours: 1));

  String locale;
  bool _isInitialized = false;

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

    return CreatePartyScaffold(
      title: widget.title,
      nextPage: '/create_party/privacy',
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Título'),),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _showDatePicker(context),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Fecha', style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: Colors.black54))),
                Text(DateFormat.yMMMd(locale).format(_partyDate) + ' ' + DateFormat('h:mm a', locale).format(_partyDate),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.subhead.merge(TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.black54, color: Colors.black54))
                )
              ]),
            ),
          ]
        )
      )
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

  String locale;
  bool _isInitialized = false;
  
  Widget _rowSpacer() => Padding(padding: EdgeInsets.only(top: 30));

  List<Widget> _privacyRadios() => [ 
    [Privacy.public, 'Public'],
    [Privacy.inviteOnly, 'Invite Only'],
    [Privacy.friends, 'Friends Only'],
    [Privacy.friendsOfFriends, 'Friends of Friends']
  ].map((x) {
    return RowAreaRadio(
      children: [
        Radio(
          value: x[0], groupValue: _partyPrivacy, 
          onChanged: (x) => setState(() => _partyPrivacy = x)
        ),
        Text(x[1], style: TextStyle(fontSize: 16))
      ]
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
      appBar: AppBar(title: Padding(padding: EdgeInsets.only(left: 8), child: Text(widget.title, style: TextStyle(fontSize: 28))), centerTitle: false),
      bottomNavigationBar: BottomAppBar(child: Row(children: [IconButton(icon: Icon(Icons.arrow_back), onPressed: null)], mainAxisAlignment: MainAxisAlignment.start), shape: CircularNotchedRectangle(),),
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.of(context).pushNamed('/create_party/details'); }, child: Icon(Icons.navigate_next)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Center(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            child: ListView(
              children: [
                Padding(padding: EdgeInsets.only(top: 25)),
                Text('Detalles', style: TextStyle(fontSize: 22, )),
                TextField(decoration: InputDecoration(labelText: 'Título')),
                LocationTextField(child: TextFormField(decoration: InputDecoration(labelText: 'Ubicación'))),
                _rowSpacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _showDatePicker(context),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Fecha', style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: Colors.black54))),
                    Text(DateFormat.yMMMd(locale).format(_partyDate) + ' ' + DateFormat('h:mm a', locale).format(_partyDate),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.subhead.merge(TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.black54, color: Colors.black54))
                    )
                  ]),
                ),
                
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 20), child: TextField(keyboardType: TextInputType.number, maxLength: 4, decoration: InputDecoration(labelText: 'Disponibilidad')))),
                  Expanded(child: TextField(keyboardType: TextInputType.number, maxLength: 2, decoration: InputDecoration(labelText: 'Edad Mínima')))
                ]),
                _rowSpacer(),
                
                Text('Privacidad', style: TextStyle(fontSize: 22)),
                Column(children: _privacyRadios(), mainAxisAlignment: MainAxisAlignment.start,),
                _rowSpacer(),

                Text('Descripción', style: TextStyle(fontSize: 22)),
                TextFormField(minLines: 1, maxLines: 5, decoration: InputDecoration(hintText: 'e.g. Escabio cada 2!'), textInputAction: TextInputAction.done,),
                _rowSpacer(),
              ]
            ),
          ),
        ),
      ),
    );
  }      
}

class CreatePartyScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final String nextPage;

  CreatePartyScaffold({this.body, this.title, this.nextPage});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: TextStyle(fontSize: 28)), centerTitle: false),
      //bottomNavigationBar: BottomAppBar(child: Row(children: [IconButton(icon: Icon(Icons.arrow_back), onPressed: null)], mainAxisAlignment: MainAxisAlignment.start), shape: CircularNotchedRectangle(),),
      floatingActionButton: _displayFloatingButton(context),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20), child: body),
    );
  }

  Widget _displayFloatingButton(BuildContext context) {
    if (nextPage == null) return null;
    
    return FloatingActionButton(onPressed: () { Navigator.of(context).pushNamed(nextPage); }, child: Icon(Icons.navigate_next));
  }
}

class RowAreaRadio extends StatelessWidget {
  final List<Widget> children;

  RowAreaRadio({this.children});

  @override
  Widget build(BuildContext context) {
    var radios = children.where((x) { return x is Radio; }).toList();
    
    if (radios.length != 1) {
      throw FormatException('You need to provide exactly 1 radio.');
    }

    Radio radio = radios.first;

    return GestureDetector(
      onTap: () => radio.onChanged(radio.value),
      child: Row(children: children,)
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