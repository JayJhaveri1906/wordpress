import 'package:flutter/material.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favourite',style: TextStyle(color: Color(0xff68617b)),),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Center(
          child: Text('There is no Favourite Item'),
        ));
  }
}
