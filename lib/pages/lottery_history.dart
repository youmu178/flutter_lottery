import 'package:flutter/material.dart';
import 'package:flutter_lottery/res/colors.dart';

class LotteryHistory extends StatelessWidget {
  final String lotteryId;

  LotteryHistory({Key key, this.lotteryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            "历史开奖",
            style: TextStyle(color: ResColor.color_333333, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Text(lotteryId),
        ));
  }
}
