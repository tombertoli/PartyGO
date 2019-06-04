import 'package:flutter/material.dart';
import 'scaffold.dart';

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
    [Privacy.inviteOnly, 'Solo los que invite'],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quienes pueden entrar a tu fiesta?', style: TextStyle(fontSize: 20)),
          Padding(padding: EdgeInsets.only(bottom: 20),),
          Column(children: _privacyRadios(), crossAxisAlignment: CrossAxisAlignment.start,),
        ],
      )   
    );
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

enum Privacy {
  public, inviteOnly, friends, friendsOfFriends
}