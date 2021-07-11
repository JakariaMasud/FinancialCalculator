import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalculatorCard extends StatelessWidget {
  final String cardTitle;
  final String cardIcon;
  final Function onPressed;

  const CalculatorCard({Key key, this.cardTitle, this.cardIcon,this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                SvgPicture.asset(cardIcon, height: 25, width: 25),
                SizedBox(
                  width: 7.0,
                ),
                Text(
                  cardTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}