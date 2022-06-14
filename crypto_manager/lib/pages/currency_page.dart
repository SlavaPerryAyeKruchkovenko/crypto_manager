import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/data.dart';
import 'package:crypto_manager/widgets/banks_grid.dart';
import 'package:crypto_manager/widgets/currency_chart_widget.dart';
import 'package:crypto_manager/widgets/flags_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  final Currency currency;
  final List<Currency> currencies;
  const CurrencyPage(
      {Key? key, required this.currency, required this.currencies})
      : super(key: key);
  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  //bool _isLoading = false;
  late Currency _nextCurrency;
  double _price1 = 0;
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  List<Rate> rates = [];
  @override
  void initState() {
    super.initState();
    _nextCurrency = widget.currencies.first;
    rates = widget.currency.rates;
    //_isLoading = true;
  }

  double _countRate(Currency cur1, Currency cur2, {double value = 1}) {
    var price = value * cur1.lastRate.value / cur2.lastRate.value;
    return price;
  }

  List<Rate> _countRates(Currency mainCur, Currency convertCur) {
    List<Rate> rates = [];
    for (var rate in mainCur.rates) {
      final value = rate.value / mainCur.lastRate.value;
      rates.add(Rate(
          course: _countRate(mainCur, convertCur, value: value),
          date: rate.date));
    }
    return rates;
  }

  final _textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  final _padding = const EdgeInsets.all(16.0);
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final currency = widget.currency;
    return Scaffold(
      appBar: _getAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: _padding,
              child: Column(
                children: [
                  Row(
                    children: [
                      _image,
                      _getTextField((p) {
                        _price1 = p;
                        var val = _countRate(currency, _nextCurrency, value: p);
                        _controller2.text = val.toString();
                      }, currency, _controller1),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  Row(children: [
                    _getCurrenciesMenu(_nextCurrency, (value) {
                      _nextCurrency = value;
                      var val =
                          _countRate(currency, _nextCurrency, value: _price1);
                      _controller2.text = val.toString();
                      rates = _countRates(currency, _nextCurrency);
                    }),
                    _getTextField((p) {
                      _price1 = _countRate(_nextCurrency, currency, value: p);
                      _controller1.text = _price1.toString();
                    }, _nextCurrency, _controller2)
                  ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 720,
            child: IndexedStack(
              index: _index,
              children: [
                currency.rates.isEmpty
                    ? _getDataNotFound(currency, "rates")
                    : _getChart(rates),
                currency.inflations == null || currency.inflations!.isEmpty
                    ? _getDataNotFound(currency, "inflations")
                    : _getChart(currency.inflations!),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: (currency.allowedCountries ?? []).isEmpty
                ? _getDataNotFound(currency, "allowed countries")
                : Container(
                    child: FlagsGrid(
                      countries: currency.allowedCountries ?? [],
                    ),
                    margin: _padding,
                  ),
          ),
          SizedBox(
            height: 400,
            child: (currency.allowedBanks ?? []).isEmpty
                ? _getDataNotFound(currency, "allowed banks")
                : Container(
                    child: BanksGrid(banks: currency.allowedBanks ?? []),
                    margin: _padding,
                  ),
          ),
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
          padding: _padding,
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
        style: _textStyle,
      ),
    );
  }

  Widget _getCurrenciesMenu(Currency currency, Function(Currency) func) {
    return Padding(
      padding: _padding,
      child: DropdownButton(
        itemHeight: 80,
        alignment: Alignment.center,
        value: currency.shortName,
        onChanged: (String? value) {
          setState(() {
            if (value != null) {
              var cur =
                  widget.currencies.firstWhere((x) => x.shortName == value);
              func(cur);
            }
          });
        },
        icon: const Icon(Icons.arrow_downward),
        items: widget.currencies
            .map((x) => x.shortName)
            .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/question_mark.png',
                          image:
                              "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@bea1a9722a8c63169dcc06e86182bf2c55a76bbc/32@2x/color/" +
                                  value.toLowerCase() +
                                  "@2x.png"),
                      padding: _padding,
                    )))
            .toList(),
      ),
    );
  }

  Widget _getTextField(Function(double) func, Currency currency,
      TextEditingController? controller) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: currency.name,
          hintText: "rate",
          icon: const Icon(Icons.send),
          border: const OutlineInputBorder(),
        ),
        style: const TextStyle(fontSize: 24),
        onChanged: (value) {
          final res = double.tryParse(value);
          if (res != null) {
            setState(() {
              func(res);
            });
          }
        },
      ),
    );
  }

  Widget get _image {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: FadeInImage.assetNetwork(
          height: 50,
          width: 50,
          placeholder: 'assets/images/question_mark.png',
          image:
              "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@bea1a9722a8c63169dcc06e86182bf2c55a76bbc/32@2x/color/" +
                  widget.currency.shortName.toLowerCase() +
                  "@2x.png"),
    );
  }
}
