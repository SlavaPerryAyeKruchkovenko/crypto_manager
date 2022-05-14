import 'package:crypto_manager/models/rate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';

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
  final gradient = const LinearGradient(colors: [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  @override
  Widget build(BuildContext context) {
    final maxY = 1.1 * widget.rates.map((e) => e.course).reduce(max);
    return LineChart(LineChartData(
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: maxY,
      titlesData: _getTitleData(),
      gridData: _getGridData(),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.blue, width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
            spots: _getData(widget.rates, now),
            isCurved: true,
            gradient: gradient,
            barWidth: 6,
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  const Color(0xff23b6e6).withOpacity(0.3),
                  const Color(0xff02d39a).withOpacity(0.3),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)))
      ],
    ));
  }

  FlTitlesData _getTitleData() {
    String _getData(String value) {
      switch (value) {
        case '2':
          return 'MAR';
        case '5':
          return 'JUN';
        case '8':
          return 'SEP';
        case '11':
          return 'DEC';
      }
      return '';
    }

    return FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: (value, meta) => Text(_getData(value.toString())),
          ),
        ));
  }

  FlGridData _getGridData() {
    return FlGridData(
      show: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.blueGrey,
        strokeWidth: 2,
      ),
      drawVerticalLine: false,
    );
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
