import 'package:crypto_manager/models/users/user.dart';

import 'currency.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> fetchCurrencies();
  Future<User> fetchUser();
}
