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
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }

      final List<Data> loadedData = [];

      for (var i = 0; i < 500; i++) {
        loadedData.add(Data(
          date: extractedData[i]['date'],
          tradeCode: extractedData[i]['trade_code'],
          high: extractedData[i]['high'],
          low: extractedData[i]['low'],
          open: extractedData[i]['open'],
          close: extractedData[i]['close'],
          volume: extractedData[i]['volume'],
        ));
      }

      _dataItems = loadedData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
