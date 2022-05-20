import '../bank.dart';

abstract class User {
  final String name;
  static User empty() {
    return Client("");
  }

  User(this.name);
}

class Admin extends User {
  static String password = "1234567";
  Admin(
    String name,
  ) : super(name);

  @override
  String toString() {
    return "Admin";
  }
}

class BankAdmin extends User {
  final Bank bank;
  BankAdmin(String name, this.bank) : super(name);

  @override
  String toString() {
    return "Bank admin";
  }
}

class Client extends User {
  Client(
    String name,
  ) : super(name);

  @override
  String toString() {
    return "Client";
  }
}
