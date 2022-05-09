class Currency {
  String name;
  double price;
  String symbol;

  Currency(this.name, this.price, this.symbol);

  Currency.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        price = map['price'],
        symbol = map['symbol'];
}
