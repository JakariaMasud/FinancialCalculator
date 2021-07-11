import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taka_app/components/Info.dart';
import 'package:taka_app/components/TitleBar.dart';
import '../models/ChartData.dart';

const MIN_LOAN = 500.0;
const MAX_LOAN = 10000.0;
const MIN_INTERST = 5.0;
const MAX_INTERST = 40.0;

class EMIScreen extends StatefulWidget {
  @override
  _EMIScreenState createState() => _EMIScreenState();
}

class _EMIScreenState extends State<EMIScreen> {
  double _loanValue = 500;
  double _interest = 5;
  double _tenure = 1;
  final _loanController = TextEditingController(text: "500");
  final _interestController = TextEditingController(text: "5");
  double _monthlyEmi, _principalAmount, _totalInterest, _totalAmount;

  @override
  Widget build(BuildContext context) {
    double annualInterest = _interest / 1200;
    double calValue = pow(1 + annualInterest, _tenure * 12);
    _monthlyEmi = _loanValue * annualInterest * calValue / (calValue - 1);
    _totalAmount = _monthlyEmi * _tenure * 12;
    _principalAmount = _loanValue;
    _totalInterest = _totalAmount - _principalAmount;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blue[50],
          child: ListView(
            children: [
              TitleBar(
                title: "EMI Calculator",
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Loan Amount'),
                    Row(
                      children: [
                        Text("৳"),
                        SizedBox(
                          height: 50.0,
                          width: 80.0,
                          child: TextField(
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            controller: _loanController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                double formattedValue = double.parse(value);
                                if (formattedValue >= MIN_LOAN &&
                                    formattedValue <= MAX_LOAN) {
                                  setState(() {
                                    _loanValue = formattedValue;
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
                  value: _loanValue,
                  min: MIN_LOAN,
                  max: MAX_LOAN,
                  onChanged: (value) {
                    setState(() {
                      _loanValue = value.ceilToDouble();
                      _loanController.text = _loanValue.ceil().toString();
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
                    Text('Loan Tenure'),
                    Text(_tenure.floor().toString() + " Yr"),
                  ],
                ),
              ),
              Slider(
                  value: _tenure,
                  min: 1,
                  max: 25,
                  onChanged: (value) {
                    setState(() {
                      _tenure = value.floorToDouble();
                    });
                  }),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Info(
                        title: "Monthly EMI",
                        value: _monthlyEmi.ceil(),
                      ),
                      Info(
                        title: "Principal Amount",
                        value: _principalAmount.ceil(),
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Info(
                        title: "Total  Interest",
                        value: _totalInterest.ceil(),
                      ),
                      Info(
                        title: "Total Amount",
                        value: _totalAmount.ceil(),
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                          dataSource: [
                            ChartData(
                                "Principal Amount", _principalAmount.ceil()),
                            ChartData("Interest Amount", _totalInterest.ceil())
                          ],
                          xValueMapper: (chartData, _) {
                            return chartData.type;
                          },
                          yValueMapper: (chartData, _) {
                            return chartData.value;
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
