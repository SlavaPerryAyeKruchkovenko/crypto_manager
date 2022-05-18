import 'package:crypto_manager/models/users/user.dart';
import 'package:flutter/material.dart';

class CurrencyMenu extends StatefulWidget {
  final User user;
  const CurrencyMenu({Key? key, required this.user}) : super(key: key);

  @override
  State<CurrencyMenu> createState() => _CurrencyMenuState();
}

const _style = TextStyle(fontSize: 24, color: Colors.white);

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
        )
      ],
    ));
  }
}
