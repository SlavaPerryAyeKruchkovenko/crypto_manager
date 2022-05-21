import 'package:crypto_manager/models/bank.dart';
import 'package:crypto_manager/models/users/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final List<Bank> banks;
  const LoginForm({Key? key, required this.banks}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  List<User> roles = List.empty();
  String _name = "";
  String _password = "";
  Bank _bank = Bank.empty();
  User _role = User.empty();
  bool _isVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _bank = widget.banks.first;
    roles = [Client(_name), BankAdmin(_name, _bank), Admin(_name)];
    if (widget.banks.isEmpty) {
      roles.remove(roles[1]);
    }
  }

  Widget get _buildRole {
    User _getRole(String? value) {
      switch (value) {
        case "Client":
          return Client(_name);
        case "Bank admin":
          return BankAdmin(_name, _bank);
        case "Admin":
          return Admin(_name);
      }
      return User.empty();
    }

    return DropdownButton(
      value: _role.toString(),
      onChanged: (String? value) {
        setState(() {
          if (value != null) {
            _role = _getRole(value);
          }
        });
      },
      icon: const Icon(Icons.arrow_downward),
      itemHeight: 80,
      items: roles
          .map((x) => x.toString())
          .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    child: Text(value, style: const TextStyle(fontSize: 24)),
                    padding: const EdgeInsets.all(24),
                  )))
          .toList(),
    );
  }

  Widget get _buildPassword {
    return TextFormField(
      maxLength: 30,
      obscureText: !_isVisible,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            icon: const Icon(Icons.lock)),
        hintText: 'Enter your password',
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is Required";
        } else if (value != Admin.password) {
          return "incorrect password";
        }
        return null;
      },
      onSaved: (newValue) => {
        setState(() {
          _password = newValue!;
        })
      },
    );
  }

  Widget get _buildName {
    return TextFormField(
      maxLength: 30,
      decoration: const InputDecoration(
          labelText: "Name", suffixIcon: Icon(Icons.person)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name is Required";
        } else if (value.split(" ").length > 1) {
          return "Name cannot contain multiple words";
        }
        return null;
      },
      onSaved: (newValue) => {
        setState(() {
          _name = newValue!;
        })
      },
    );
  }

  Widget get _buildBank {
    Bank _getBank(String? value) {
      return value == null
          ? Bank.empty()
          : widget.banks.firstWhere((x) => x.toString() == value);
    }

    return widget.banks.isEmpty
        ? const Center(
            child: Text(
            "Active banks not found",
            style: TextStyle(fontSize: 24),
          ))
        : DropdownButton(
            itemHeight: 80,
            alignment: Alignment.center,
            value: _bank.toString(),
            onChanged: (String? value) {
              setState(() {
                if (value != null) {
                  _bank = _getBank(value);
                }
              });
            },
            icon: const Icon(Icons.arrow_downward),
            items: widget.banks
                .map((x) => x.toString())
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

  Widget _getFormField(Widget child) {
    return Center(
        child: Padding(padding: const EdgeInsets.all(24.0), child: child));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text('Login Form'),
      )),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _getFormField(_buildName),
              _getFormField(_buildRole),
              _getFormField(
                  _role is BankAdmin ? _buildBank : const SizedBox.shrink()),
              _getFormField(
                  _role is Admin ? _buildPassword : const SizedBox.shrink()),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
