import 'dart:async';

import 'package:crypto_manager/models/currency.dart';

import '../currency_repository.dart';

class MockCurrencyRepository implements CurrencyRepository {
  @override
  Future<List<Currency>> fetchCurrencies() {
    return Future.value(currencies);
  }
}

var currencies = <Currency>[
  Currency("Bitcoin", 228.0, "btc"),
  Currency("Ethereum", 14.88, "eth"),
  Currency("Ripple", 300.00, "xrp"),
];
