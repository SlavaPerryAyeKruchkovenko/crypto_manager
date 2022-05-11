import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/storage.dart';

class Bank {
  final String adress;
  final String country;
  final List<Storage>? storagingCurrencies;

  Bank({required this.adress, required this.country, this.storagingCurrencies});
}
