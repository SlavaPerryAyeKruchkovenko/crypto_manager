import 'package:crypto_manager/models/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  final Currency currency;
  const CurrencyPage({Key? key, required this.currency}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
    );
  }

  AppBar _getAppBar() {
    return AppBar(title: const Text('Currency information'), actions: const []);
  }
}
