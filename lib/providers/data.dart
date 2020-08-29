import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data with ChangeNotifier {
  final String id;
  final String date;
  final String tradeCode;
  final String high;
  final String low;
  final String open;
  final String close;
  final String volume;

  Data({
    @required this.id,
    @required this.date,
    @required this.tradeCode,
    @required this.high,
    @required this.low,
    @required this.open,
    @required this.close,
    @required this.volume,
  });
}
