import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taka_app/components/Info.dart';
import 'package:taka_app/components/TitleBar.dart';
import 'package:taka_app/models/ChartData.dart';

const MIN_INVEST = 500.0;
const MAX_INVEST = 10000.0;
const MIN_INTERST = 5.0;
const MAX_INTERST = 40.0;

class MutualFundReturnScreen extends StatefulWidget {
  const MutualFundReturnScreen({Key key}) : super(key: key);

  @override
  _MutualFundReturnScreenState createState() => _MutualFundReturnScreenState();
}

class _MutualFundReturnScreenState extends State<MutualFundReturnScreen> {
  double _investValue = 500;
  double _interest = 5;
  double _periodInYear = 1;
  final _investController = TextEditingController(text: "500");
  final _interestController = TextEditingController(text: "5");
  double _estReturn;
  double _calValue;
  double _totalValue;

  @override
  Widget build(BuildContext context) {
    double temp = _interest / 1200;
    _calValue = pow(1 + temp, _periodInYear * 12);
    _totalValue = _investValue * _calValue;
    _estReturn = _totalValue - _investValue;

    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          TitleBar(
            title: "Mutual Fund Return Calculator",
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Invest Amount'),
                Row(
                  children: [
                    Text("৳"),
                    SizedBox(
                      height: 50.0,
                      width: 80.0,
                      child: TextField(
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        controller: _investController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            double formattedValue = double.parse(value);
                            if (formattedValue >= MIN_INVEST &&
                                formattedValue <= MAX_INVEST) {
                              setState(() {
                                _investValue = formattedValue;
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Slider(
              value: _investValue,
              min: MIN_INVEST,
              max: MAX_INVEST,
              onChanged: (value) {
                setState(() {
                  _investValue = value.ceilToDouble();
                  _investController.text = _investValue.ceil().toString();
                });
              }),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expected Return Rate'),
                Row(
                  children: [
                    SizedBox(
                      height: 50.0,
                      width: 80.0,
                      child: TextField(
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        controller: _interestController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            double formattedValue = double.parse(value);
                            if (formattedValue >= MIN_INTERST &&
                                formattedValue <= MAX_INTERST) {
                              setState(() {
                                _interest = formattedValue;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    Text("%"),
                  ],
                ),
              ],
            ),
          ),
          Slider(
              value: _interest,
              min: MIN_INTERST,
              max: MAX_INTERST,
              onChanged: (value) {
                setState(() {
                  _interest = value.ceilToDouble();
                  _interestController.text = _interest.ceil().toString();
                });
              }),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time Period'),
                Text(_periodInYear.floor().toString() + " Yr"),
              ],
            ),
          ),
          Slider(
              value: _periodInYear,
              min: 1,
              max: 25,
              onChanged: (value) {
                setState(() {
                  _periodInYear = value.floorToDouble();
                });
              }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Info(
                    title: "Invested Amount",
                    value: _investValue.ceil(),
                  ),
                  Info(
                    title: "Est. Returns",
                    value: _estReturn.ceil(),
                  ),
                ]),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Info(title: "Total Value", value: _totalValue.ceil()),
          )),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: SfCircularChart(
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                    dataSource: getChartData(),
                    xValueMapper: (chartData, _) {
                      return chartData.type;
                    },
                    yValueMapper: (chartData, _) {
                      return chartData.value;
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartDataList = [
      ChartData("Invest Amount", _investValue.ceil()),
      ChartData("Est. Returns", _estReturn.ceil())
    ];
    return chartDataList;
  }
}
