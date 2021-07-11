import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String title;
  final int value;
  const Info({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 15.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          "৳ $value",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
