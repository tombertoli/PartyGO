import 'package:flutter/material.dart';
import 'scaffold.dart';

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