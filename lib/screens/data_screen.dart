import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_data/providers/data_list.dart';
import 'package:connectivity/connectivity.dart';
import 'package:stock_market_data/screens/trade_code_screen.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  var _isInit = true;
  var _isLoading = false;
  bool _isInternetOn = true;

  @override
  void initState() {
    connectionCheck();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<DataList>(context).fetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> connectionCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataInfo = Provider.of<DataList>(context);
    final data = dataInfo.dataItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Data Visualization'),
      ),
      body: !_isInternetOn
          ? Center(
              child: Text(
                'Please connect to the internet and re-open the app.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          buildDataColumn('Date', false, 'This is Date'),
                          buildDataColumn(
                              'Trade Code', false, 'This is Trade Code'),
                          buildDataColumn('High', false, 'This is High'),
                          buildDataColumn('Low', false, 'This is Low'),
                          buildDataColumn('Open', false, 'This is Open'),
                          buildDataColumn('Close', false, 'This is Close'),
                          buildDataColumn('Volume', false, 'This is Volume'),
                        ],
                        rows: data
                            .map(
                              (dt) => DataRow(
                                cells: [
                                  buildDataCell(dt.date),
                                  buildTradeCodeDataCell(dt.tradeCode),
                                  buildDataCell(dt.high),
                                  buildDataCell(dt.low),
                                  buildDataCell(dt.open),
                                  buildDataCell(dt.close),
                                  buildDataCell(dt.volume),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
    );
  }

  DataColumn buildDataColumn(
      final String label, final bool numeric, final String tooltip) {
    return DataColumn(
      label: Text(label),
      numeric: numeric,
      tooltip: tooltip,
    );
  }

  DataCell buildDataCell(final String str) {
    return DataCell(
      Text(str),
    );
  }

  DataCell buildTradeCodeDataCell(final String str) {
    return DataCell(
      Text(str),
      onTap: () {
        Navigator.of(context).pushNamed(TradeCodeScreen.routeName);
      },
    );
  }
}
