import 'package:crypto_manager/models/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyChart extends StatefulWidget {
  final List<Data> rates;
  const CurrencyChart({
    required this.rates,
    Key? key,
  }) : super(key: key);

  @override
  State<CurrencyChart> createState() => _CurrencyChartState();
}

class _CurrencyChartState extends State<CurrencyChart> {
  var now = DateTime.now();
  var gradient = const LinearGradient(colors: [
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.yellowAccent,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  @override
  Widget build(BuildContext context) {
    final maxY = 1.1 * widget.rates.map((e) => e.value).reduce(math.max);
    return LineChart(LineChartData(
      minX: 0.0,
      maxX: 12.0,
      minY: 0.0,
      maxY: maxY,
      titlesData: _getTitleData(),
      gridData: _getGridData(),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.blue, width: 1.0),
      ),
      lineBarsData: [
        LineChartBarData(
            spots: _getData(widget.rates, now),
            isCurved: true,
            gradient: gradient,
            barWidth: 6.0,
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  Colors.orangeAccent.withOpacity(0.3),
                  Colors.redAccent.withOpacity(0.3),
                  Colors.yellowAccent.withOpacity(0.3),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)))
      ],
    ));
  }

  FlTitlesData _getTitleData() {
    String _getBottomTitle(double value) {
      final now = DateTime.now().month.toDouble();
      final res = ((value + now) % 12);
      if (res.round() - res == 0) {
        return DateFormat('MMM')
            .format(DateTime(0, res.round() + 1))
            .toUpperCase();
      }
      return "";
    }

    String _getLeftTitle(double value) {
      return value.toString().length > 5
          ? value.toStringAsExponential(2)
          : value.toString();
    }

    Widget _getLeftWidget(double value, TitleMeta meta) {
      Widget text = Text(
        _getLeftTitle(value),
        style: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      );
      bool isBigDifirent = (meta.max / meta.appliedInterval -
              (meta.max / meta.appliedInterval).ceil()) <
          0.5;
      return Container(
        margin: meta.max == value && isBigDifirent
            ? const EdgeInsets.fromLTRB(0, 0, 0, 10)
            : EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        child: text,
      );
    }

    return FlTitlesData(
        show: true,
        topTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60.0,
            getTitlesWidget: _getLeftWidget,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30.0,
            getTitlesWidget: (value, meta) => Text(
              _getBottomTitle(value),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }

  FlGridData _getGridData() {
    return FlGridData(
      show: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.blueGrey,
        strokeWidth: 2.0,
      ),
      drawVerticalLine: false,
    );
  }

  List<FlSpot> _getData(List<Data> rates, DateTime now) {
    Iterable<Data> _getCorrectData(List<Data> rates, DateTime now) {
      return rates.where((x) =>
          x.date != null &&
          (x.date!.year == now.year ||
              (x.date!.year == now.year - 1 && x.date!.month > now.month)));
    }

    double _parseDateToNum(DateTime date, DateTime now) {
      double res = (date.month + 11 - now.month) % 12;
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
        final spot = FlSpot(_parseDateToNum(rate.date!, now), rate.value);
        spots.add(spot);
      }
    }
    return spots;
  }
}
