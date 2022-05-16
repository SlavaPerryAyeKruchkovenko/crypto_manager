import 'package:crypto_manager/models/currency.dart';

class Storage {
  final DateTime startDate;
  final DateTime finishDate;
  final Currency currency;
  Storage(
      {required this.currency,
      required this.startDate,
      required this.finishDate});
}
