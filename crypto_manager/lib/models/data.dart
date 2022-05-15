import 'package:intl/intl.dart';

abstract class Data {
  final DateTime? date;
  final double value;
  Data({this.date, required this.value});

  @override
  String toString() {
    //DateFormat.yMMMMd()
    String dateT = date == null
        ? ""
        : "data: " + DateFormat.yMMMMd().format(date!).toUpperCase() + " ";
    return dateT;
  }
}

class Inflation extends Data {
  Inflation({DateTime? date, required double persent})
      : super(date: date, value: persent);
  @override
  String toString() {
    String superStr = super.toString();
    return superStr + "persent: $value";
  }
}

class Rate extends Data {
  Rate({DateTime? date, required double course})
      : super(date: date, value: course);
  @override
  String toString() {
    String superStr = super.toString();
    return superStr + "course: $value";
  }
}