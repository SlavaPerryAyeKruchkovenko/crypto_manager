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
  Currency("Bitcoin", Rate(course: 228.28), "btc", true),
  Currency("Ethereum", Rate(course: 14.88), "eth", true),
  Currency("Ripple", Rate(course: 300.01), "xrp", false),
  Currency("Dollar", Rate(course: 1), "usd", true),
];
