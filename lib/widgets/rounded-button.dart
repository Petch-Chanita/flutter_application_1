import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundeButton extends StatelessWidget {
  const RoundeButton({
    Key key,
    @required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.deepPurple),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          buttonName,
          style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
