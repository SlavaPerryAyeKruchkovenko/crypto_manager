import 'currency.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> fetchCurrencies();
}
