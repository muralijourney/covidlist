import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sliver_bar_chart/sliver_bar_chart.dart';
import 'package:untitled/common/NormalText.dart';

import '../dataModel/covid_response_model.dart';

class CovidBarChart extends StatefulWidget {
  final Countries countriesModel;

  const CovidBarChart({Key? key, required this.countriesModel})
      : super(key: key);

  @override
  _CovidBarChartState createState() => _CovidBarChartState();
}

class _CovidBarChartState extends State<CovidBarChart>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final List<BarChartData> _barValues;

  final double _minHeight = AppBar().preferredSize.height;
  final double _xAxisTextRotationAngle = 180.0;
  final int _yAxisIntervalCount = 8;
  double _maxHeight = 500.0;
  double _maxWidth = 10.0;

  final bool _restrain = true;
  final bool _fluctuating = false;
  bool _isScrolling = true;
  final int _sliverListChildCount = 20;

  @override
  void initState() {
    super.initState();
    _setupBarChartValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NormalText(text: widget.countriesModel.country.toString(),fontWeight: FontWeight.bold,fontSize: 30,fontcolor: Colors.white,),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverBarChart(
            restrain: _restrain,
            fluctuating: _fluctuating,
            minHeight: _minHeight,
            maxHeight: _maxHeight,
            maxWidth: _maxWidth,
            barWidget: BarChartWidget(
              maxHeight: _maxHeight,
              minHeight: _minHeight,
              barValues: _barValues,
              isScrolling: _isScrolling,
              yAxisIntervalCount: _yAxisIntervalCount,
              xAxisTextRotationAngle: _xAxisTextRotationAngle,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext _, int index) => Container(),
              childCount: _sliverListChildCount,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _setupBarChartValues() {
    _barValues = [
      BarChartData(
        x: "NewConfirmed",
        y: widget.countriesModel.newConfirmed!.toDouble(),
        barColor: _getRandomColor(),
      ),
      BarChartData(
        x: 'TotalConfirmed',
        y: widget.countriesModel.totalConfirmed!.toDouble(),
        barColor: _getRandomColor(),
      ),
      BarChartData(
        x: 'NewDeaths',
        y: widget.countriesModel.newDeaths!.toDouble(),
        barColor: _getRandomColor(),
      ),
      BarChartData(
        x: 'TotalDeaths',
        y: widget.countriesModel.totalDeaths!.toDouble(),
        barColor: _getRandomColor(),
      ),
      BarChartData(
        x: 'NewRecovered',
        y: widget.countriesModel.newRecovered!.toDouble(),
        barColor: _getRandomColor(),
      ),
      BarChartData(
        x: 'TotalRecovered',
        y: widget.countriesModel.totalRecovered!.toDouble(),
        barColor: _getRandomColor(),
      ),
    ];
  }

  Color _getRandomColor() {
    return Color(
      (math.Random().nextDouble() * 0xFFFFFF).toInt(),
    ).withOpacity(1.0);
  }
}
