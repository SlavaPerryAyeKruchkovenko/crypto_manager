import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/currency.dart';
import 'modules/currency_prisenter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage>
    implements CurrencyListViewContract {
  late CurrencyListPresenter _presenter;
  List<Currency> _currencies = List.empty();
  bool _isLoading = false;

  _HomePageState() {
    _presenter = CurrencyListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Currency Converter'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _currencies.length,
                itemBuilder: (BuildContext context, int index) =>
                    _getRowWithDivider(index),
              ));
  }

  Widget _getRowWithDivider(int i) {
    final Currency currency = _currencies[i];
    var children = <Widget>[
      Padding(
          padding: const EdgeInsets.all(5), child: _getListItemUI(currency)),
      const Divider(height: 5),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ListTile _getListItemUI(Currency currency) {
    final price = currency.price;
    final text = "$price\$";
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(
          "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@bea1a9722a8c63169dcc06e86182bf2c55a76bbc/32@2x/color/" +
              currency.symbol.toLowerCase() +
              "@2x.png",
        ),
        placeholder: const NetworkImage("assets\\question mark.png"),
      ),
      title: Text(
        currency.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: RichText(
        text: TextSpan(text: text),
      ),
    );
  }

  @override
  void onLoadCryptoComplete(List<Currency> items) {
    setState(() {
      _currencies = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadCryptoError() {}
}
