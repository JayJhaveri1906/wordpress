import 'package:flutter/material.dart';
import 'package:soledesign/TestingOrientation/detailWidget.dart';


class DetailPage extends StatefulWidget {
  final int data;
  DetailPage(this.data);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DetailWidget(widget.data),
    );
  }
}
