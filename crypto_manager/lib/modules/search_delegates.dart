import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/widgets/currency_widget.dart';
import 'package:flutter/material.dart';

class MySearchDelegates extends SearchDelegate {
  final List<Currency> _currencies;
  MySearchDelegates(this._currencies);
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () =>
                {if (query.isEmpty) close(context, null) else query = ""},
            icon: const Icon(Icons.clear))
      ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => {
            close(context, null),
          },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 32),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    var currencies = _currencies
        .where((x) => x.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (BuildContext context, int index) {
        final currency = currencies[index];
        return CurrencyWidget(
          currency: currency,
          currencies: currencies,
        );
      },
    );
  }
}
