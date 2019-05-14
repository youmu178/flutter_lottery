import 'package:flutter/material.dart';
import 'package:flutter_lottery/res/colors.dart';
import 'package:flutter_lottery/util/utils.dart';

class LotteryMain extends StatelessWidget {
  final String numbers = "07,10,11,15,24,26,11";
  int numberIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "彩票开奖",
          style: TextStyle(color: ResColor.color_333333, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
          height: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              itemBuilder: (BuildContext context, int index) {
                return getItem(context);
              })),
    );
  }

  Widget getItem(BuildContext context) {
    numberIndex = 0;
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("双色球",
                    style:
                        TextStyle(color: ResColor.color_333333, fontSize: 16)),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 12),
                  child: Text("19054",
                      style: TextStyle(
                          color: ResColor.color_B3B3B3, fontSize: 13)),
                ),
                Text("2019-05-12 星期日",
                    style:
                        TextStyle(color: ResColor.color_B3B3B3, fontSize: 13))
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 9),
              child: Row(
                children: numbers.split(',').map((number) {
                  ++ numberIndex;
                  return Container(
                    margin: EdgeInsets.only(right: 4),
                    child: ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: numberIndex <= Utils.getLotteryItemRedCount("ssq") ? ResColor.color_F63F3F : ResColor.color_508CEE,
                        child: Center(
                          child: Text(
                            number,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
