import 'package:flutter/material.dart';
import 'package:flutter_lottery/bloc/BlocProvider.dart';
import 'package:flutter_lottery/bloc/MainBloc.dart';
import 'package:flutter_lottery/model/Lottery.dart';
import 'package:flutter_lottery/pages/widget/widget.dart';
import 'package:flutter_lottery/res/colors.dart';
import 'package:flutter_lottery/util/utils.dart';

import 'lottery_history.dart';

class LotteryMain extends StatelessWidget {
  int numberIndex = 0;

  @override
  Widget build(BuildContext context) {
    MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    _mainBloc.getLotteryInfo();
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
        child: StreamBuilder<List<LotteryInfo>>(
          initialData: List<LotteryInfo>(),
          stream: _mainBloc.lotteryInfoStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<LotteryInfo>> snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                itemBuilder: (BuildContext context, int index) {
                  return getItem(context, snapshot.data[index]);
                });
          },
        ),
      ),
    );
  }

  Widget getItem(BuildContext context, LotteryInfo info) {
    numberIndex = 0;
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 15),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(info.lotteryName,
                          style:
                        TextStyle(color: ResColor.color_333333, fontSize: 16)),
                      Container(
                        padding: EdgeInsets.only(left: 8, right: 12),
                        child: Text(info.lotteryNo,
                            style: TextStyle(
                                color: ResColor.color_B3B3B3, fontSize: 13)),
                      ),
                      Text(info.lotteryDate + " " +
                          Utils.getWeekDay(info.lotteryDate),
                          style:
                        TextStyle(color: ResColor.color_B3B3B3, fontSize: 13))
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 9),
                    child: Row(
                      children: info.lotteryRes.split(',').map((number) {
                        ++numberIndex;
                        return Container(
                          margin: EdgeInsets.only(right: 4),
                          child: ClipOval(
                            child: Container(
                              width: 30,
                              height: 30,
                              color: Utils.getLotteryItemColor(
                                  numberIndex, info.lotteryId),
                              child: Center(
                                child: Text(
                                  number,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 9),
                    child: Row(
                      children: <Widget>[
                        Item(
                          text: "历史开奖",
                          callback: () {
                            NavigatorUtil.pushPage(context,
                                LotteryHistory(lotteryId: info.lotteryId));
                          },
                        ),
                        Item(
                          text: "中奖计算器",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 8,
              child: Offstage(
                  offstage: !Utils.isShowFlag(info.lotteryId),
                  child: Image(
                      width: 30,
                      height: 30,
                      image: AssetImage("assets/images/ic_kj_flag.png"))),
            )

          ],
        )
    );
  }
}
