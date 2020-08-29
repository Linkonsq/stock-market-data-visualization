import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Data Visualization'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Text('Hello'),
              )
            ],
          )
        ],
      ),
    );
  }
}
