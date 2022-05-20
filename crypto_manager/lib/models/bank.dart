import 'package:crypto_manager/models/storage.dart';

class Bank {
  final String adress;
  final Country country;
  final List<Storage>? storagingCurrencies;
  final String name;

  Bank(this.name,
      {required this.adress, required this.country, this.storagingCurrencies});

  static Bank empty() {
    return Bank("", adress: "", country: Country(name: ""));
  }

  @override
  String toString() {
    final country = this.country.toString();
    return "$name $country";
  }
}

class Country {
  final String name;
  final String? shortName;
  Country({required this.name, this.shortName});
  @override
  String toString() {
    return name;
  }
}
