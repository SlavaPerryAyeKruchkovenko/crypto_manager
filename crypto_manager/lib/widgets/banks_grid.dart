import 'package:crypto_manager/models/bank.dart';
import 'package:flutter/cupertino.dart';

class BanksGrid extends StatefulWidget {
  final List<Bank> banks;
  const BanksGrid({Key? key, required this.banks}) : super(key: key);

  @override
  State<BanksGrid> createState() => _BanksGridState();
}

class _BanksGridState extends State<BanksGrid> {
  final _textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Allowed Banks",
            style: _textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: GridView.count(
          crossAxisCount: 8,
          children: List.generate(widget.banks.length, (index) {
            final bank = widget.banks[index].name.toUpperCase();
            return Center(
              child: Text(
                bank,
                style: _textStyle,
                textAlign: TextAlign.center,
              ),
            );
          }),
        )),
      ],
    );
  }
}
