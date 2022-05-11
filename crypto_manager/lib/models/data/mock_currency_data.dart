import 'dart:async';

import 'package:crypto_manager/models/currency.dart';

import '../currency_repository.dart';
import '../rate.dart';

class MockCurrencyRepository implements CurrencyRepository {
  @override
  Future<List<Currency>> fetchCurrencies() {
    return Future.value(currencies);
  }
}

var currencies = <Currency>[
  Currency("Bitcoin", "btc", true,
      rates: [Rate(date: DateTime.now(), course: 228.28)]),
  Currency("Ethereum", "eth", true,
      rates: [Rate(date: DateTime.now(), course: 14.88)]),
  Currency("Ripple", "xrp", false,
      rates: [Rate(date: DateTime.now(), course: 300.01)]),
  Currency("Dollar", "usd", true,
      rates: [Rate(date: DateTime.now(), course: 300.01)]),
];
