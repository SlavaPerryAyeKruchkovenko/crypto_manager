import 'package:crypto_manager/models/rate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class CurrencyChart extends StatefulWidget {
  final List<Rate> rates;
  const CurrencyChart({
    required this.rates,
    Key? key,
  }) : super(key: key);

  @override
  State<CurrencyChart> createState() => _CurrencyChartState();
}

class _CurrencyChartState extends State<CurrencyChart> {
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final maxY = widget.rates.map((e) => e.course).reduce(max);
    return LineChart(LineChartData(
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: _getData(widget.rates, now),
        )
      ],
    ));
  }

  List<FlSpot> _getData(List<Rate> rates, DateTime now) {
    Iterable<Rate> _getCorrectData(List<Rate> rates, DateTime now) {
      return rates.where((x) =>
          x.date != null &&
          (x.date!.year == now.year ||
              (x.date!.year == now.year - 1 && x.date!.month > now.month)));
    }

    double _parseDateToNum(DateTime date, DateTime now) {
      double res = ((date.month + 11 - now.month) % 12) as double;
      var firstDayThisMonth = DateTime(date.year, date.month, date.day);
      var firstDayNextMonth = DateTime(firstDayThisMonth.year,
          firstDayThisMonth.month + 1, firstDayThisMonth.day);
      final days = firstDayNextMonth.difference(firstDayThisMonth).inDays;
      res += 0.9 * date.day / days;
      res += 0.1 * date.hour / 24;
      return res;
    }

    final spots = <FlSpot>[];
    for (var rate in _getCorrectData(rates, now)) {
      if (rate.date != null) {
        final spot = FlSpot(_parseDateToNum(rate.date!, now), rate.course);
        spots.add(spot);
      }
    }
    return spots;
  }
}
