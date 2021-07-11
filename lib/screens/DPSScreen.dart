import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taka_app/components/Info.dart';
import 'package:taka_app/components/TitleBar.dart';
import 'package:taka_app/models/ChartData.dart';

const MIN_INVEST = 500.0;
const MAX_INVEST = 10000.0;
const MIN_INTERST = 5.0;
const MAX_INTERST = 40.0;

class DPSScreen extends StatefulWidget {
  const DPSScreen({Key key}) : super(key: key);

  @override
  _DPSScreenState createState() => _DPSScreenState();
}

class _DPSScreenState extends State<DPSScreen> {
  double _monthlyInvest = 500;
  double _interest = 5;
  double _periodInYear = 1;
  final _investController = TextEditingController(text: "500");
  final _interestController = TextEditingController(text: "5");
  double _totalInterest;
  double _totalInvestment;
  double _maturityValue;
  @override
  Widget build(BuildContext context) {
    double periodInMonth = _periodInYear * 12;
    _totalInterest =
        (_monthlyInvest * periodInMonth * (periodInMonth + 1) * _interest) /
            2400;
    _totalInvestment = _monthlyInvest * periodInMonth;
    _maturityValue = _totalInvestment + _totalInterest;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            TitleBar(
              title: "DPS Calculator",
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Monthly Investment'),
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
                                  _monthlyInvest = formattedValue;
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
                value: _monthlyInvest,
                min: MIN_INVEST,
                max: MAX_INVEST,
                onChanged: (value) {
                  setState(() {
                    _monthlyInvest = value.ceilToDouble();
                    _investController.text = _monthlyInvest.ceil().toString();
                  });
                }),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rate of Interest'),
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
                  Text(_periodInYear.round().toString() + " Yr"),
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
                      title: "Total Investment",
                      value: _totalInvestment.ceil(),
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
              child:
                  Info(title: "Maturity Value", value: _maturityValue.ceil()),
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
      ChartData("Total Investment", _totalInvestment.ceil()),
      ChartData("Total Interest", _totalInterest.ceil())
    ];
    return chartDataList;
  }
}
