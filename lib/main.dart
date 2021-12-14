import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  late List<_ChartData> data;
  late List<_ChartData> data2;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData(1, 12),
      _ChartData(2, 15),
      _ChartData(3, 30),
      _ChartData(4, 6.4),
      _ChartData(5, 14)
    ];
    data2 = [
      _ChartData(1, 24),
      _ChartData(2, 20),
      _ChartData(3, 10),
      _ChartData(4, 11.4),
      _ChartData(5, 19),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
          isVisible: false,
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: 0,
          maximum: 50,
          interval: 10,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
        ),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<_ChartData, double>>[
          AreaSeries<_ChartData, double>(
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            name: 'Gold',
            color: Colors.blue.withOpacity(0.7),
          ),
          AreaSeries<_ChartData, double>(
            dataSource: data2,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            name: 'Gold',
            color: Colors.red.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final double x;
  final double y;
}
