import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_data/providers/data_list.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    final dataInfo = Provider.of<DataList>(context);
    final data = dataInfo.dataItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Data Visualization'),
      ),
//      body: SingleChildScrollView(
//        scrollDirection: Axis.horizontal,
//        child: SingleChildScrollView(
//          child: dataBody(data),
//        ),
//      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                return DataTable(
                  columns: [
                    DataColumn(
                      label: Text('Date'),
                      numeric: false,
                      tooltip: 'This is Date',
                    ),
                    DataColumn(
                      label: Text('Trade Code'),
                      numeric: false,
                      tooltip: 'This is Trade Code',
                    ),
                    DataColumn(
                      label: Text('High'),
                      numeric: false,
                      tooltip: 'This is High',
                    ),
                    DataColumn(
                      label: Text('Low'),
                      numeric: false,
                      tooltip: 'This is Low',
                    ),
                    DataColumn(
                      label: Text('Open'),
                      numeric: false,
                      tooltip: 'This is Open',
                    ),
                    DataColumn(
                      label: Text('Close'),
                      numeric: false,
                      tooltip: 'This is Close',
                    ),
                    DataColumn(
                      label: Text('Volume'),
                      numeric: false,
                      tooltip: 'This is Volume',
                    ),
                  ],
                  rows: data
                      .map(
                        (dt) => DataRow(
                          cells: [
                            DataCell(
                              Text(dt.date),
                            ),
                            DataCell(
                              Text(dt.tradeCode),
                            ),
                            DataCell(
                              Text(dt.high),
                            ),
                            DataCell(
                              Text(dt.low),
                            ),
                            DataCell(
                              Text(dt.open),
                            ),
                            DataCell(
                              Text(dt.close),
                            ),
                            DataCell(
                              Text(dt.volume),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                );
              },
            ),
    );
  }
}
