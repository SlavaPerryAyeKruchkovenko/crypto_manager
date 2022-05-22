import 'package:crypto_manager/models/users/user.dart';

import 'bank.dart';
import 'currency.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> fetchCurrencies();
  Future<User> fetchUser();
  Future<List<Bank>> fetchBanks();
}
