import 'package:flutter/material.dart';

class TradeCodeScreen extends StatelessWidget {
  static const routeName = '/tradeCodeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Code'),
      ),
      body: Center(
        child: Text('This is trade code page.'),
      ),
    );
  }
}
