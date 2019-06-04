import 'package:flutter/material.dart';
import 'scaffold.dart';

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
          TextFormField(minLines: 5, maxLines: 5, decoration: InputDecoration(hintText: 'e.g. Escabio cada 2!'), textInputAction: TextInputAction.done,),
        ]
      ),
    );
  }
}