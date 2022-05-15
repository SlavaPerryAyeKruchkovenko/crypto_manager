import 'package:crypto_manager/models/currency.dart';
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

  @override
  Widget build(BuildContext context) {
    final currency = widget.currency;
    return Scaffold(
      appBar: _getAppBar(),
      body: Stack(
        children: [
          currency.rates.isEmpty
              ? _getDataNotFound(currency)
              : _getChart(currency),
        ],
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(title: const Text('Currency information'), actions: const []);
  }

  Widget _getChart(Currency currency) {
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
          rates: currency.rates,
        ),
      ),
    );
  }

  Widget _getDataNotFound(Currency currency) {
    final text = currency.name;
    return Center(
      child: Text(
        "no $text data found",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
