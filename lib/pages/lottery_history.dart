import 'package:flutter/material.dart';
import 'package:flutter_lottery/bloc/BlocProvider.dart';
import 'package:flutter_lottery/bloc/MainBloc.dart';
import 'package:flutter_lottery/model/LotteryHistory.dart';
import 'package:flutter_lottery/res/colors.dart';
import 'package:flutter_lottery/util/utils.dart';

class LotteryHistory extends StatelessWidget {
  final String lotteryId;

  LotteryHistory({Key key, this.lotteryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    _mainBloc.getLotteryHistory(lotteryId, 1);
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
        height: double.infinity,
        child: RefreshIndicator(
            child: StreamBuilder<List<LotteryResListListBean>>(
              initialData: List<LotteryResListListBean>(),
              stream: _mainBloc.lotteryHistoryStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<LotteryResListListBean>> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    itemBuilder: (BuildContext context, int index) {
                      if (index.isOdd) return new Divider();
                      return getItem(context, snapshot.data[index], index);
                    });
              },
            ),
            onRefresh: () {
              return _mainBloc.refreshHistory(lotteryId);
            }),
      ),
    );
  }

  Widget getItem(BuildContext context, LotteryResListListBean data, int index) {
    int numberIndex = 0;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 12),
                child: Text(data.lotteryNo + "期",
                    style: TextStyle(
                        color: ResColor.color_B3B3B3, fontSize: 14)),
              ),
              Text(
                  data.lotteryDate + " " + Utils.getWeekDay(data.lotteryDate),
                  style:
                  TextStyle(color: ResColor.color_B3B3B3, fontSize: 13))
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 9),
            child: Row(
              children: data.lotteryRes.split(',').map((number) {
                ++numberIndex;
                return index > 0 ? Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    number,
                    style: TextStyle(color: Utils.getLotteryItemColor(
                        numberIndex, data.lotteryId),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ) : Container(
                  margin: EdgeInsets.only(right: 4),
                  child: ClipOval(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Utils.getLotteryItemColor(
                          numberIndex, data.lotteryId),
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
          ),
        ],
      ),
    );
  }
}
