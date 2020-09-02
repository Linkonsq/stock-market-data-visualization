import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_data/providers/data_list.dart';
import 'package:stock_market_data/screens/data_screen.dart';
import 'package:stock_market_data/screens/trade_code_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => DataList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DataScreen(),
        routes: {
          TradeCodeScreen.routeName: (ctx) => TradeCodeScreen(),
        },
      ),
    );
  }
}
