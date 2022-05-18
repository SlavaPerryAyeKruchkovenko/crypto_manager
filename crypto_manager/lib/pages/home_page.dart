import 'package:crypto_manager/modules/search_delegates.dart';
import 'package:crypto_manager/widgets/currency_widget.dart';
import 'package:flutter/cupertino.dart';
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
    with TickerProviderStateMixin
    implements CurrencyListViewContract {
  late CurrencyListPresenter _presenter;
  List<Currency> _currencies = List.empty();
  List<Currency> _usedCurrencies = List.empty();
  bool _isLoading = false;
  bool _isLikeClick = false;
  late AnimationController controller;
  _HomePageState() {
    _presenter = CurrencyListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                value: controller.value,
              ),
            )
          : _usedCurrencies.isEmpty
              ? _getNotFoundResult()
              : ListView.builder(
                  itemCount: _usedCurrencies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _getRowWithDivider(index);
                  },
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: Row(
          children: [
            _getLikeSortBtn(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.update),
        onPressed: () {},
      ),
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(title: const Text('Currency Converter'), actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => {
          showSearch(
              context: context, delegate: MySearchDelegates(_usedCurrencies))
        },
      )
    ]);
  }

  Widget _getLikeSortBtn() {
    return IconButton(
      icon: Icon(
        _isLikeClick ? Icons.favorite : Icons.favorite_border_sharp,
        color: _isLikeClick ? Colors.pink : Colors.black,
      ),
      onPressed: () {
        setState(() {
          if (!_isLikeClick) {
            _usedCurrencies =
                _usedCurrencies.where((x) => x.isFavorite).toList();
            _isLikeClick = true;
          } else {
            _usedCurrencies = _currencies;
            _isLikeClick = false;
          }
        });
      },
    );
  }

  Widget _getRowWithDivider(int i) {
    final Currency currency = _usedCurrencies[i];
    return CurrencyWidget(currency: currency);
  }

  Widget _getNotFoundResult() {
    return const Center(
      child: Text(
        "Data not found",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void onLoadCryptoComplete(List<Currency> items) {
    setState(() {
      _currencies = items;
      _usedCurrencies = _currencies;
      _isLoading = false;
      controller.dispose();
    });
  }

  @override
  void onLoadCryptoError() {}
}
