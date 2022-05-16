import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/data.dart';
import 'package:crypto_manager/widgets/currency_chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  final Currency currency;
  const CurrencyPage({Key? key, required this.currency}) : super(key: key);
  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  //bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    //_isLoading = true;
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    final currency = widget.currency;
    return Scaffold(
      appBar: _getAppBar(),
      body: IndexedStack(
        index: index,
        children: [
          currency.rates.isEmpty
              ? _getDataNotFound(currency, "rates")
              : _getChart(currency.rates),
          currency.inflations == null || currency.inflations!.isEmpty
              ? _getDataNotFound(currency, "inflations")
              : _getChart(currency.inflations!),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: Row(
          children: [Text("$index")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(index == 0 ? Icons.navigate_next : Icons.navigate_before),
        onPressed: () {
          setState(() {
            index = (index + 1) % 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _getAppBar() {
    return AppBar(title: const Text('Currency information'), actions: const []);
  }

  Widget _getChart(List<Data> data) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.amber[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CurrencyChart(
          rates: data,
        ),
      ),
    );
  }

  Widget _getDataNotFound(Currency currency, String property) {
    final text = currency.name;
    return Center(
      child: Text(
        "no $text's $property data found",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
