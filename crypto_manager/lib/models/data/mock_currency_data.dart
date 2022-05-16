import 'dart:async';

import 'package:crypto_manager/models/currency.dart';

import '../currency_repository.dart';
import '../data.dart';

class MockCurrencyRepository implements CurrencyRepository {
  @override
  Future<List<Currency>> fetchCurrencies() {
    return Future.value(currencies);
  }
}

final date1 = DateTime(2021, 6, 12, 7);
final date2 = DateTime(2021, 12, 7, 16);
final date3 = DateTime(2022, 2, 18, 23);
final rates = [
  Rate(course: 228.28, date: DateTime.now()),
  Rate(course: 12, date: date1),
  Rate(course: 239, date: date2),
  Rate(course: 102, date: date3),
];
var currencies = <Currency>[
  Currency("Bitcoin", "btc", true, rates: rates, inflations: [
    Inflation(persent: 0.01, date: date1),
    Inflation(persent: 0.03, date: date2),
    Inflation(persent: 0.05, date: date3),
    Inflation(persent: 0.001, date: DateTime.now()),
  ]),
  Currency("Ethereum", "eth", true, rates: [
    Rate(date: DateTime.now(), course: 14.88),
  ]),
  Currency("Ripple", "xrp", false,
      rates: [Rate(date: DateTime.now(), course: 300.01)]),
  Currency("Dollar", "usd", true,
      rates: [Rate(date: DateTime.now(), course: 1)]),
  Currency("Ruble", "rub", true,
      rates: [Rate(date: DateTime.now(), course: 0.01492537313)]),
];
