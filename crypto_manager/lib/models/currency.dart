import 'package:crypto_manager/models/inflation.dart';
import 'package:crypto_manager/models/rate.dart';

class Currency {
  String name;
  String shortName;
  List<Inflation>? inflation;
  Rate rate;
  bool isFavorite;

  Currency(this.name, this.rate, this.shortName, this.isFavorite,
      {this.inflation});

  void like() {
    isFavorite = true;
  }

  void dislike() {
    isFavorite = false;
  }

  Currency.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        rate = map['rate'],
        shortName = map['symbol'],
        inflation = map['inflation'],
        isFavorite = map['like'];
}
