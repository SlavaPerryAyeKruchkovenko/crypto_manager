import 'models/currency_repository.dart';
import 'models/data/mock_currency_data.dart';
import 'models/users/user.dart';

enum Flavor { mock, prod }

//DI
class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor = Flavor.mock;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  CurrencyRepository get cryptoRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockCurrencyRepository();
      default:
        return MockCurrencyRepository();
    }
  }
}
