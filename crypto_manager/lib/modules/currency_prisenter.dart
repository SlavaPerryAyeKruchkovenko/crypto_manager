import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/currency_repository.dart';

import '../dependency_injection.dart';

abstract class CurrencyListViewContract {
  void onLoadCryptoComplete(List<Currency> items);
  void onLoadCryptoError();
}

class CurrencyListPresenter {
  final CurrencyListViewContract _view;
  late CurrencyRepository _repository;

  CurrencyListPresenter(this._view) {
    _repository = Injector().cryptoRepository;
  }

  void loadCurrencies() {
    _repository
        .fetchCurrencies()
        .then((c) => _view.onLoadCryptoComplete(c))
        .catchError((onError) => _view.onLoadCryptoError());
  }
}
