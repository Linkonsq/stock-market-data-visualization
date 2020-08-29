import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_market_data/providers/data.dart';

class DataList with ChangeNotifier {
  List<Data> _dataItems = [];

  List<Data> get dataItems {
    return [..._dataItems];
  }

  Future<void> fetchData() async {
    const url = 'https://stock-market-data-fa5db.firebaseio.com/.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Data> loadedData = [];

      if (extractedData == null) {
        return;
      }

      extractedData.forEach((dataId, dataInfo) {
        loadedData.add(Data(
          date: dataInfo['date'],
          tradeCode: dataInfo['trade_code'],
          high: dataInfo['high'],
          low: dataInfo['low'],
          open: dataInfo['open'],
          close: dataInfo['close'],
          volume: dataInfo['volume'],
        ));
      });

      _dataItems = loadedData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
