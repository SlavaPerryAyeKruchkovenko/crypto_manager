import 'package:crypto_manager/models/bank.dart';
import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/data.dart';
import 'package:crypto_manager/widgets/currency_chart_widget.dart';
import 'package:flag/flag_widget.dart';
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

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final currency = widget.currency;
    return Scaffold(
      appBar: _getAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 720,
            child: IndexedStack(
              index: _index,
              children: [
                currency.rates.isEmpty
                    ? _getDataNotFound(currency, "rates")
                    : _getChart(currency.rates),
                currency.inflations == null || currency.inflations!.isEmpty
                    ? _getDataNotFound(currency, "inflations")
                    : _getChart(currency.inflations!),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: (currency.allowedCountries ?? []).isEmpty
                ? _getDataNotFound(currency, "allowed countries")
                : Stack(
                    children: _getFlags(currency.allowedCountries ?? []),
                  ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: Row(
          children: [Text("$_index")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_index == 0 ? Icons.navigate_next : Icons.navigate_before),
        onPressed: () {
          setState(() {
            _index = (_index + 1) % 2;
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
          child: Stack(children: [
            Center(
              child: Text(
                data.first.name + "s",
                style: TextStyle(color: Colors.redAccent[900], fontSize: 24),
              ),
            ),
            CurrencyChart(
              rates: data,
            ),
          ])),
    );
  }

  ///return Text as "no [currency]'s [property] data found"
  Widget _getDataNotFound(Currency currency, String property) {
    final text = currency.name;
    return Center(
      child: Text(
        "no $text's $property data found",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _getFlags(List<Country> countries) {
    double left = 0;

    final flags = <Widget>[];
    if (countries.isNotEmpty) {
      for (var country in countries) {
        if (country.shortName != null && country.shortName!.length == 2) {
          flags.add(Positioned(
              left: left,
              child: Flag.fromString(
                country.shortName!.toLowerCase(),
                height: 30,
                width: 30,
              )));
          left += 30;
        } else {
          flags.add(Text(
            country.name,
            style: const TextStyle(fontSize: 16),
          ));
        }
      }
    }
    return flags;
  }
}
