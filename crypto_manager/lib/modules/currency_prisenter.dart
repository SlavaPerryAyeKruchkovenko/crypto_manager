import 'package:crypto_manager/models/bank.dart';
import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/currency_repository.dart';
import 'package:crypto_manager/models/users/user.dart';

import '../dependency_injection.dart';

abstract class CurrencyListViewContract {
  void onLoadCryptoComplete(List<Currency> items);
  void onLoadCryptoError();
  void onLoadUserComplete(User user);
  void onLoadUserError();
  void onLoadBanksComplete(List<Bank> banks);
  void onLoadBanksError();
}

class CurrencyListPresenter {
  final CurrencyListViewContract _view;
  late CurrencyRepository _repository;

  CurrencyListPresenter(this._view) {
    _repository = Injector().cryptoRepository;
  }
  void loadUser() {
    _repository
        .fetchUser()
        .then((x) => _view.onLoadUserComplete(x))
        .catchError((e) => _view.onLoadUserError());
  }

  void loadCurrencies() {
    _repository
        .fetchCurrencies()
        .then((c) => _view.onLoadCryptoComplete(c))
        .catchError((onError) => _view.onLoadCryptoError());
  }

  void loadBanks() {
    _repository
        .fetchBanks()
        .then((x) => _view.onLoadBanksComplete(x))
        .catchError((e) => _view.onLoadBanksError());
  }

  void updateData() {}
}
