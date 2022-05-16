import 'package:crypto_manager/models/storage.dart';

class Bank {
  final String adress;
  final Country country;
  final List<Storage>? storagingCurrencies;

  Bank({required this.adress, required this.country, this.storagingCurrencies});
}

class Country {
  final String name;
  final String? shortName;
  Country({required this.name, this.shortName});
}
