import '../bank.dart';

abstract class User {
  final String name;
  User(this.name);
}

class Admin extends User {
  Admin(String name) : super(name);
}

class BankAdmin extends User {
  final Bank bank;
  BankAdmin(String name, this.bank) : super(name);
}

class Client extends User {
  Client(String name) : super(name);
}
