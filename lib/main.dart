import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<LiveData> chartData;
  late List<LiveData> chartData2;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;

  @override
  void initState() {
    chartData = getChartData();
    chartData2 = getChartData2();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //color: Colors.black,
          height: 200,
          child: SfCartesianChart(
            backgroundColor: Colors.black,
            plotAreaBorderWidth: 0,
            margin: EdgeInsets.all(0),
            series: <ChartSeries<LiveData, int>>[
              SplineAreaSeries<LiveData, int>(
                borderColor: Colors.red,
                borderWidth: 2,
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                },
                dataSource: chartData,
                color: Colors.red.withOpacity(0.5),
                xValueMapper: (LiveData sales, _) => sales.time,
                yValueMapper: (LiveData sales, _) => sales.speed,
              ),
              SplineAreaSeries<LiveData, int>(
                borderColor: Colors.blue,
                borderWidth: 2,
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController2 = controller;
                },
                dataSource: chartData2,
                color: Colors.blue.withOpacity(0.5),
                xValueMapper: (LiveData sales, _) => sales.time,
                yValueMapper: (LiveData sales, _) => sales.speed,
              ),
            ],
            primaryXAxis: NumericAxis(
              isVisible: false,
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: AxisLine(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              interval: 3,
            ),
            primaryYAxis: NumericAxis(
              isVisible: false,
              majorGridLines: MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
            ),
          ),
        ),
      ),
    );
  }

  int time = 10;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
      addedDataIndex: chartData.length - 1,
      removedDataIndex: 0,
    );
    chartData2.add(LiveData(time, (math.Random().nextInt(30) + 10)));
    chartData2.removeAt(0);
    _chartSeriesController2.updateDataSource(
      addedDataIndex: chartData2.length - 1,
      removedDataIndex: 0,
    );
    time++;
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 0),
      LiveData(2, 0),
      LiveData(3, 0),
      LiveData(4, 0),
      LiveData(5, 0),
      LiveData(6, 0),
      LiveData(7, 0),
      LiveData(8, 0),
      LiveData(9, 0),
    ];
  }

  List<LiveData> getChartData2() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 0),
      LiveData(2, 0),
      LiveData(3, 0),
      LiveData(4, 0),
      LiveData(5, 0),
      LiveData(6, 0),
      LiveData(7, 0),
      LiveData(8, 0),
      LiveData(9, 0),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
