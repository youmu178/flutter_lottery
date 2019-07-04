import 'package:flutter/material.dart';
import 'package:flutter_lottery/bloc/MainBloc.dart';
import 'package:flutter_lottery/model/Lottery.dart';
import 'package:flutter_lottery/res/colors.dart';
import 'package:flutter_lottery/util/utils.dart';

class LotteryDetail extends StatelessWidget {
  final String lotteryId;
  final String lotteryNo;

  LotteryDetail({Key key, this.lotteryId, this.lotteryNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    _mainBloc.getLotteryDetail(lotteryId, lotteryNo);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            Utils.getLotteryName(lotteryId),
            style: TextStyle(color: ResColor.color_333333, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<LotteryResultBean>(
                  stream: _mainBloc.lotteryStream,
                  initialData: LotteryResultBean(),
                  builder: (BuildContext context,
                      AsyncSnapshot<LotteryResultBean> snapshot) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                              [HeadWidget(data: snapshot.data)]),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class HeadWidget extends StatelessWidget {
  final LotteryResultBean data;

  HeadWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberIndex = 0;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset("assets/images/bg_kj.png"),
          Positioned(
            top: 10,
            left: 15,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(data!= null ? data.lotteryNo + "期" : "",
                      style: TextStyle(
                          color: ResColor.color_999999, fontSize: 13)),
                ),
                Text(
                    data != null
                        ? data.lotteryDate +
                            " " +
                            Utils.getWeekDay(data.lotteryDate)
                        : "",
                    style:
                        TextStyle(color: ResColor.color_999999, fontSize: 13))
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            child: Row(
              children: data.lotteryRes.split(',').map((number) {
                ++numberIndex;
                return Container(
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
          )
        ],
      ),
    );
  }
}
