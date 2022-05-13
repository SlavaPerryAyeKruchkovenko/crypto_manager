import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/rate.dart';
import 'package:crypto_manager/pages/currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CurrencyWidget extends StatefulWidget {
  final Currency currency;
  const CurrencyWidget({Key? key, required this.currency}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<CurrencyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: _getCurrienceImage(),
      ),
      const Divider(height: 5),
    ]);
  }

  double _cnvrtData(Rate rate) {
    return rate.date!.year +
        0.1 * rate.date!.month +
        0.01 * rate.date!.day +
        0.001 * rate.date!.hour;
  }

  Widget _getCurrienceImage() {
    widget.currency.rates
        .sort((x, y) => _cnvrtData(y).compareTo(_cnvrtData(x)));
    final price = widget.currency.rates.first.course;
    final date = widget.currency.rates.first.date;

    var text = "$price\$ date: $date";
    return ListTile(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CurrencyPage(
                      currency: widget.currency,
                    )))
      },
      leading: FadeInImage(
        image: NetworkImage(
          "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@bea1a9722a8c63169dcc06e86182bf2c55a76bbc/32@2x/color/" +
              widget.currency.shortName.toLowerCase() +
              "@2x.png",
        ),
        placeholder: const NetworkImage("assets\\question mark.png"),
      ),
      title: Text(
        widget.currency.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: RichText(
        text: TextSpan(text: text),
      ),
      trailing: _getLikeWidget(),
    );
  }

  Widget _getLikeWidget() {
    return widget.currency.isFavorite
        ? IconButton(
            onPressed: () => {
              setState(() {
                widget.currency.dislike();
              })
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
          )
        : IconButton(
            onPressed: () => {
                  setState(() {
                    widget.currency.like();
                  })
                },
            icon: const Icon(Icons.favorite_border));
  }
}
