import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taka_app/components/CalculatorCard.dart';
import 'package:taka_app/screens/CompoundInterestScreen.dart';
import 'package:taka_app/screens/DPSScreen.dart';
import 'package:taka_app/screens/MutualFundReturnScreen.dart';
import 'EMIScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "icons/leads.svg",
                  height: 20,
                  width: 20,
                ),
                label: "Leads"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "icons/sales.svg",
                  height: 20,
                  width: 20,
                ),
                label: "Sales"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "icons/create.svg",
                  height: 20,
                  width: 20,
                ),
                label: "Create"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "icons/calculators.svg",
                  height: 20,
                  width: 20,
                ),
                label: "Calculator"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "icons/account.svg",
                  height: 20,
                  width: 20,
                ),
                label: "Account"),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: Container(
          color: Colors.blue[100],
          child: ListView(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.75))
                ], color: Colors.white),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Help",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0, top: 15.0, bottom: 8.0),
                child: Text(
                  'Calculators',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
                ),
              ),
              CalculatorCard(
                cardTitle: "SIP Calculator",
                cardIcon: "icons/sip.svg",
              ),
              CalculatorCard(
                cardTitle: "Mutual Fund Return Calculator",
                cardIcon: "icons/mutualfund.svg",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutualFundReturnScreen()));
                },
              ),
              CalculatorCard(
                cardTitle: "EPF Calculator",
                cardIcon: "icons/epf.svg",
              ),
              CalculatorCard(
                cardTitle: "DPS Calculator",
                cardIcon: "icons/fd.svg",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DPSScreen()));
                },
              ),
              CalculatorCard(
                cardTitle: "NPS Calculator",
                cardIcon: "icons/nps.svg",
              ),
              CalculatorCard(
                cardTitle: "Retirement Calculator",
                cardIcon: "icons/retirement.svg",
              ),
              CalculatorCard(
                cardTitle: "EMI Calculator",
                cardIcon: "icons/emi.svg",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EMIScreen()));
                },
              ),
              CalculatorCard(
                cardTitle: "Car Load EMI Calculator",
                cardIcon: "icons/carLoan.svg",
              ),
              CalculatorCard(
                cardTitle: "Home Loan EMI Calculator",
                cardIcon: "icons/homeLoan.svg",
              ),
              CalculatorCard(
                cardTitle: "Compound Interest Calculator",
                cardIcon: "icons/compound.svg",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompoundInterestScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
