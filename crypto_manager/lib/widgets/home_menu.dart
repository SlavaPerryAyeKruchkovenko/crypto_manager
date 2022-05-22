import 'package:crypto_manager/models/bank.dart';
import 'package:crypto_manager/models/currency.dart';
import 'package:crypto_manager/models/users/user.dart';
import 'package:crypto_manager/pages/convert_page.dart';
import 'package:crypto_manager/pages/login_page.dart';
import 'package:flutter/material.dart';

class CurrencyMenu extends StatefulWidget {
  final User user;
  final List<Bank> banks;
  final List<Currency> currencies;
  const CurrencyMenu(
      {Key? key,
      required this.user,
      required this.banks,
      required this.currencies})
      : super(key: key);

  @override
  State<CurrencyMenu> createState() => _CurrencyMenuState();
}

const _style = TextStyle(fontSize: 24, color: Colors.white);
const _style2 = TextStyle(
  fontSize: 24,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

class _CurrencyMenuState extends State<CurrencyMenu> {
  late User _user;
  Future<User> _logInUser(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginForm(
                  banks: widget.banks,
                )));
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    final name = _user.name;
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.blue),
          child: Text("Hello 👋 $name", style: _style),
        ),
        const Divider(
          height: 4,
          thickness: 1,
          color: Colors.cyan,
        ),
        ListTile(
          leading: const Icon(
            Icons.money,
            color: Colors.blue,
          ),
          title: const Text(
            'Convert currency',
            style: _style2,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConvertPage(
                          currencies: widget.currencies,
                        )));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.account_box,
            color: Colors.blue,
          ),
          title: const Text('Change acount', style: _style2),
          onTap: () {
            setState(() async {
              _user = await _logInUser(context);
            });
          },
        ),
      ],
    ));
  }
}
