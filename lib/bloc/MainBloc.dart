import 'package:dio/dio.dart';
import 'package:flutter_lottery/api/api_index.dart';
import 'package:flutter_lottery/model/Lottery.dart';
import 'package:flutter_lottery/util/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'BlocProvider.dart';

class MainBloc implements BlocBase {
  BehaviorSubject<List<LotteryInfo>> _lotteryInfoController =
      BehaviorSubject<List<LotteryInfo>>();

  Sink<List<LotteryInfo>> get _lotteryInfoSink => _lotteryInfoController.sink;

  Stream<List<LotteryInfo>> get lotteryInfoStream =>
      _lotteryInfoController.stream;

  getLotteryInfo() {
    ApiRepository.getInstance().queryLotteryList().doOnDone(() {
      print("doOnDone");
    }).doOnListen(() {
      print("doOnListen");
    }).doOnError((error, stacktrace) {
      if (error is DioError) {
        Utils.showToast("加载失败，请检查网络连接");
      }
    }).listen((onData) {
      List<LotteryInfo> lotteryList = onData.map((data) {
        var result = data.data['result'];
//        if (result == null)
//          return List<LotteryInfo>();
        return LotteryInfo(
            lotteryId: result['lottery_id'],
            lotteryName: result['lottery_name'],
            lotteryNo: result['lottery_no'],
            lotteryDate: result['lottery_date'],
            lotteryRes: result['lottery_res']);
      }).toList();
      _lotteryInfoSink.add(lotteryList);
    });
  }

  @override
  void dispose() {
    _lotteryInfoController.close();
  }
}
