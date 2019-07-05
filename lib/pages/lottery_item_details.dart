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
                              [
                                HeadWidget(data: snapshot.data),
                                TableLotteryWidget(data: snapshot.data)
                              ]),
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
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 20),
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
                      child: Text(data != null ? data.lotteryNo + "期" : "",
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
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
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(data.lotterySaleAmount, style: TextStyle(
                      fontSize: 20, color: ResColor.color_666666
                  ),),
                  Text("本期销量", style: TextStyle(
                      fontSize: 13, color: ResColor.color_999999
                  ),)
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(data.lotteryPoolAmount, style: TextStyle(
                      fontSize: 20, color: ResColor.color_666666
                  ),),
                  Text("奖池滚存", style: TextStyle(
                      fontSize: 13, color: ResColor.color_999999
                  ),)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class TableLotteryWidget extends StatelessWidget {

  final LotteryResultBean data;

  TableLotteryWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LotteryPrizeListBean lotteryPrizeListBean = new LotteryPrizeListBean();
    lotteryPrizeListBean.prizeName = "奖项";
    lotteryPrizeListBean.prizeRequire = "中奖条件";
    lotteryPrizeListBean.prizeNum = "中奖注数";
    lotteryPrizeListBean.prizeAmount = "单注奖金(元)";
    data.lotteryPrize.insert(0, lotteryPrizeListBean);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
          color: ResColor.color_F3F3F3,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        children: data.lotteryPrize.map((d) {
          return TableRow(
              children: [
                Container(
                  height: 42,
                  child: ItemText(
                      text: d.prizeName, list: data.lotteryPrize, data: d),
                ),
                Center(
                    child: ItemText(text: d.prizeRequire,
                        list: data.lotteryPrize,
                        data: d)),
                Center(
                    child: ItemText(
                        text: d.prizeNum, list: data.lotteryPrize, data: d)),
                Center(
                    child: ItemText(
                        text: d.prizeAmount, list: data.lotteryPrize, data: d)),
              ]
          );
        }).toList(),
      ),
    );
  }
}

class ItemText extends StatelessWidget {

  final List<LotteryPrizeListBean> list;
  final LotteryPrizeListBean data;
  final String text;

  ItemText({
    Key key,
    this.list,
    this.text,
    this.data
  }) : super(key: key);


  getIndex(LotteryPrizeListBean data) {
    return list.indexOf(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: TextStyle(
          color: getIndex(data) > 0 ? ResColor.color_333333 : ResColor
              .color_999999, fontSize: getIndex(data) > 0 ? 14 : 12)),
    );
  }
}


