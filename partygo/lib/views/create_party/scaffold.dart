import 'package:flutter/material.dart';

class CreatePartyScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final String nextPage;

  CreatePartyScaffold({this.body, this.title, this.nextPage});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Padding(padding: ModalRoute.of(context).isFirst ? EdgeInsets.only(left: 8) : EdgeInsets.zero, child: Text(title, style: TextStyle(fontSize: 28))), centerTitle: false),
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