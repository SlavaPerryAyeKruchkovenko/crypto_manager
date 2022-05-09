import 'package:crypto_manager/modules/search_delegates.dart';
import 'package:crypto_manager/widgets/currency_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/currency.dart';
import '../modules/currency_prisenter.dart';

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
      appBar: AppBar(title: const Text('Currency Converter'), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => {
            showSearch(
                context: context, delegate: MySearchDelegates(_currencies))
          },
        )
      ]),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _currencies.length,
              itemBuilder: (BuildContext context, int index) =>
                  _getRowWithDivider(index),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: Row(
          children: [
            //add_alert_outlined
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _getRowWithDivider(int i) {
    final Currency currency = _currencies[i];
    return CurrencyWidget(currency: currency);
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
