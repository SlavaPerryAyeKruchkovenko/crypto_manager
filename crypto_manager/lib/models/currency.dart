import 'package:crypto_manager/models/bank.dart';

import 'data.dart';

class Currency {
  String name;
  String shortName;
  final List<Inflation>? inflations;
  late List<Rate> rates;
  final List<Bank>? allowedBanks;
  final List<Country>? allowedCountries;
  late final Rate lastRate;
  bool isFavorite;

  Currency(this.name, this.shortName, this.isFavorite,
      {this.inflations,
      required this.rates,
      this.allowedBanks,
      this.allowedCountries}) {
    rates.sort((x, y) => y.date!.compareTo(x.date!));
    lastRate = rates.first;
  }

  void like() {
    isFavorite = true;
  }

  void dislike() {
    isFavorite = false;
  }

  Currency.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        shortName = map['symbol'],
        inflations = null,
        allowedCountries = null,
        allowedBanks = null,
        isFavorite = map['like'],
        lastRate = map['rate'];
}
