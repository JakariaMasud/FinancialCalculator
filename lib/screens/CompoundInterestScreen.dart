import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taka_app/components/Info.dart';
import 'package:taka_app/components/TitleBar.dart';
import 'package:taka_app/models/ChartData.dart';

const MIN_PRINCIPAL = 500.0;
const MAX_PRINCIPAL = 10000.0;
const MIN_INTERST = 5.0;
const MAX_INTERST = 40.0;
const TYPES = ["Yearly", "Half-Yearly", "Quarterly"];

class CompoundInterestScreen extends StatefulWidget {
  const CompoundInterestScreen({Key key}) : super(key: key);

  @override
  _CompoundInterestScreenState createState() => _CompoundInterestScreenState();
}

class _CompoundInterestScreenState extends State<CompoundInterestScreen> {
  double _principal = 500;
  double _interest = 5;
  double _timePeriod = 1;
  double _totalInterest, _totalValue;
  final _principalController = TextEditingController(text: "500");
  final _interestController = TextEditingController(text: "5");
  String _dropDownValue = TYPES[0];
  double calcValue, helperValue;

  @override
  Widget build(BuildContext context) {
    if (_dropDownValue == TYPES[0]) {
      helperValue = _interest / 100;
      calcValue = pow(1 + helperValue, _timePeriod);
      _totalValue = _principal * calcValue;
      _totalInterest = _totalValue - _principal;
    } else if (_dropDownValue == TYPES[1]) {
      helperValue = _interest / 200;
      calcValue = pow(1 + helperValue, _timePeriod * 2);
      _totalValue = _principal * calcValue;
      _totalInterest = _totalValue - _principal;
    } else if (_dropDownValue == TYPES[2]) {
      helperValue = _interest / 400;
      calcValue = pow(1 + helperValue, _timePeriod * 4);
      _totalValue = _principal * calcValue;
      _totalInterest = _totalValue - _principal;
    }
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            TitleBar(
              title: "Compound Interest Calculator",
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Principal Amount'),
                  Row(
                    children: [
                      Text("৳"),
                      SizedBox(
                        height: 50.0,
                        width: 80.0,
                        child: TextField(
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          controller: _principalController,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              double formattedValue = double.parse(value);
                              if (formattedValue >= MIN_PRINCIPAL &&
                                  formattedValue <= MAX_PRINCIPAL) {
                                setState(() {
                                  _principal = formattedValue;
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
                value: _principal,
                min: MIN_PRINCIPAL,
                max: MAX_PRINCIPAL,
                onChanged: (value) {
                  setState(() {
                    _principal = value.ceilToDouble();
                    _principalController.text = _principal.ceil().toString();
                  });
                }),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Interest Rate'),
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
                  Text(_timePeriod.floor().toString() + " Yr"),
                ],
              ),
            ),
            Slider(
                value: _timePeriod,
                min: 1,
                max: 25,
                onChanged: (value) {
                  setState(() {
                    _timePeriod = value.floorToDouble();
                  });
                }),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Text("Compounding Frequency : "),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          _dropDownValue = value;
                        });
                      },
                      value: _dropDownValue,
                      items: TYPES
                          .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              )))
                          .toList())
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Info(
                      title: "Principal Amount",
                      value: _principal.ceil(),
                    ),
                    Info(
                      title: "Total Interest",
                      value: _totalInterest.ceil(),
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
      ),
    );
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartDataList = [
      ChartData("Principal Amount", _principal.ceil()),
      ChartData("Total Interest", _totalInterest.ceil())
    ];
    return chartDataList;
  }
}
