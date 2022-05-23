import 'package:crypto_manager/models/bank.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';

class FlagsGrid extends StatefulWidget {
  final List<Country> countries;
  const FlagsGrid({Key? key, required this.countries}) : super(key: key);

  @override
  State<FlagsGrid> createState() => _FlagsGridState();
}

class _FlagsGridState extends State<FlagsGrid> {
  final _textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Allowed Country",
            style: _textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 8,
            children: List.generate(widget.countries.length, (index) {
              final id = widget.countries[index].shortName!.toLowerCase();
              final country = widget.countries[index].name.toUpperCase();
              return Center(
                child: Flag.flagsCode.contains(id)
                    ? Flag.fromString(id)
                    : Text(
                        country,
                        style: _textStyle,
                        textAlign: TextAlign.center,
                      ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
