import 'package:crypto_manager/models/currency.dart';
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

  Widget _getCurrienceImage() {
    final rate = widget.currency.lastRate;

    var text = rate.toString();
    return ListTile(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CurrencyPage(
                      currency: widget.currency,
                    )))
      },
      leading: FadeInImage.assetNetwork(
          placeholder: 'assets/images/question_mark.png',
          image:
              "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@bea1a9722a8c63169dcc06e86182bf2c55a76bbc/32@2x/color/" +
                  widget.currency.shortName.toLowerCase() +
                  "@2x.png"),
      title: Text(
        widget.currency.name,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: RichText(
        text: TextSpan(text: text, style: const TextStyle(color: Colors.black)),
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
