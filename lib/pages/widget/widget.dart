import 'package:flutter/material.dart';
import 'package:flutter_lottery/res/colors.dart';

class Item extends StatelessWidget {
  final String text;
  final GestureTapCallback callback;

  Item({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: InkWell(
          onTap: callback,
          child: Container(
            color: ResColor.color_F4F4F4,
            height: 30,
            width: 80,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: ResColor.color_666666,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
