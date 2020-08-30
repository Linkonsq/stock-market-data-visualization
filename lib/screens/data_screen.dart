import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market_data/providers/data.dart';
import 'package:stock_market_data/providers/data_list.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  var _isInit = true;
  //var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<DataList>(context).fetchData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

//  @override
//  void didChangeDependencies() {
//    if (_isInit) {
//      setState(() {
//        _isLoading = true;
//      });
//      Provider.of<DataList>(context).fetchData().then((_) {
//        setState(() {
//          _isLoading = false;
//        });
//      });
//    }
//    _isInit = false;
//    super.didChangeDependencies();
//  }

  DataTable dataBody(List<Data> dataInfo) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text('Date'),
        ),
        DataColumn(
          label: Text('Trade Code'),
        ),
        DataColumn(
          label: Text('High'),
        ),
        DataColumn(
          label: Text('low'),
        ),
        DataColumn(
          label: Text('Open'),
        ),
        DataColumn(
          label: Text('Close'),
        ),
        DataColumn(
          label: Text('Volume'),
        ),
      ],
      rows: dataInfo
          .map(
            (data) => DataRow(
              cells: [
                DataCell(
                  Text(data.date),
                ),
                DataCell(
                  Text(data.tradeCode),
                ),
                DataCell(
                  Text(data.high),
                ),
                DataCell(
                  Text(data.low),
                ),
                DataCell(
                  Text(data.open),
                ),
                DataCell(
                  Text(data.close),
                ),
                DataCell(
                  Text(data.volume),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataInfo = Provider.of<DataList>(context);
    final data = dataInfo.dataItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Data Visualization'),
      ),
      body: //_isLoading
//          ? Center(
//              child: CircularProgressIndicator(),
//            )
          ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: dataBody(data),
              )
            ],
          )
        ],
      ),
    );
  }
}
