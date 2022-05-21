import 'package:crypto_manager/models/bank.dart';
import 'package:crypto_manager/models/users/user.dart';
import 'package:crypto_manager/pages/login_page.dart';
import 'package:flutter/material.dart';

class CurrencyMenu extends StatefulWidget {
  final User user;
  final List<Bank> banks;
  const CurrencyMenu({Key? key, required this.user, required this.banks})
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
  @override
  Widget build(BuildContext context) {
    final name = widget.user.name;
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
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(
            Icons.account_box,
            color: Colors.blue,
          ),
          title: const Text('Change acount', style: _style2),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginForm(
                          banks: widget.banks,
                        )))
          },
        ),
      ],
    ));
  }
}
