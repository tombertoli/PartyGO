import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'scaffold.dart';

class CreatePartyDetailsPage extends StatefulWidget {
  final String title;

  CreatePartyDetailsPage({this.title});

  @override
  State<StatefulWidget> createState() => _CreatePartyDetailsPageState();
}

class _CreatePartyDetailsPageState extends State<CreatePartyDetailsPage> {
  DateTime _partyDate;
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
  void initState() {
    super.initState();
    _partyDate = DateTime.now().add(Duration(hours: 1));
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Como se va a llamar tu fiesta?', style: TextStyle(fontSize: 20)),
          TextField(decoration: InputDecoration(hintText: 'e.g. La fiesta de Jorgito'),),
          Padding(padding: EdgeInsets.only(top: 20)),

          Text('Cuando va a ser?', style: TextStyle(fontSize: 20)),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _showDatePicker(context),
            child: TextField(
              controller: TextEditingController(text: DateFormat.yMMMd(locale).format(_partyDate) + ' ' + DateFormat('h:mm a', locale).format(_partyDate)),
              textAlign: TextAlign.left,
              enabled: false,
              decoration: InputDecoration(enabled: true),
            )
          ),
        ]
      )
    );
  } 
}