import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'views/create_party/details.dart';
import 'views/create_party/privacy.dart';
import 'views/create_party/availability.dart';
import 'views/create_party/description.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'PartyGO',
    theme: ThemeData(primaryColor: Colors.purple),
    home: CreatePartyDetailsPage(title: 'Crear Fiesta'),
    routes: {
      '/create_party/': (context) => CreatePartyDetailsPage(title: 'Crear Fiesta'),
      '/create_party/privacy': (context) => CreatePartyPrivacyPage(title: 'Privacidad'),
      '/create_party/availability': (context) => CreatePartyAvailabilityPage(title: 'Disponibilidad'),
      '/create_party/description': (context) => CreatePartyDescriptionPage(title: 'Info Adicional'),
    },
  );
}