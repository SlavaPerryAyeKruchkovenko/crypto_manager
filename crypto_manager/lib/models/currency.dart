import 'package:crypto_manager/models/bank.dart';
import 'package:crypto_manager/models/inflation.dart';
import 'package:crypto_manager/models/rate.dart';

class Currency {
  String name;
  String shortName;
  List<Inflation>? inflations;
  late List<Rate> rates;
  List<Bank>? allowedBanks;
  bool isFavorite;

  Currency(this.name, this.shortName, this.isFavorite,
      {this.inflations, required this.rates, this.allowedBanks});

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
        isFavorite = map['like'];
}
