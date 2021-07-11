import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String title;
  const TitleBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 0.75))
      ], color: Colors.white),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
