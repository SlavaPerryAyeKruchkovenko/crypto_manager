import 'package:crypto_manager/models/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConvertPage extends StatefulWidget {
  final List<Currency> currencies;
  const ConvertPage({Key? key, required this.currencies}) : super(key: key);

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  late Currency _currency1;
  late Currency _currency2;

  @override
  void initState() {
    super.initState();
    _currency1 = widget.currencies.first;
    _currency2 = _currency1;
  }

  AppBar get _appBar {
    return AppBar(
        title: const Center(
      child: Text('Login Form'),
    ));
  }

  Widget _getCurrenciesMenu(Currency currency, Function(Currency) func) {
    return DropdownButton(
      itemHeight: 80,
      alignment: Alignment.center,
      value: currency.name,
      onChanged: (String? value) {
        setState(() {
          if (value != null) {
            var cur = widget.currencies.firstWhere((x) => x.name == value);
            func(cur);
          }
        });
      },
      icon: const Icon(Icons.arrow_downward),
      items: widget.currencies
          .map((x) => x.name)
          .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 24),
                    ),
                    padding: const EdgeInsets.all(24),
                  )))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                _getCurrenciesMenu(_currency1, (value) => _currency1 = value),
                Text(_currency1.name)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Row(
              children: [
                _getCurrenciesMenu(_currency2, (value) => _currency2 = value),
                Text(_currency2.name)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ],
        ),
      ),
    );
  }
}
