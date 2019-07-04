import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_lottery/api/api_index.dart';
import 'package:flutter_lottery/model/Lottery.dart';
import 'package:flutter_lottery/model/LotteryHistory.dart';
import 'package:flutter_lottery/util/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'BlocProvider.dart';
export 'BlocProvider.dart';

class MainBloc implements BlocBase {
  /// 获取开奖列表
  BehaviorSubject<List<LotteryInfo>> _lotteryInfoController =
      BehaviorSubject<List<LotteryInfo>>();

  Sink<List<LotteryInfo>> get _lotteryInfoSink => _lotteryInfoController.sink;

  Stream<List<LotteryInfo>> get lotteryInfoStream =>
      _lotteryInfoController.stream;

  /// 获取开奖历史列表
  BehaviorSubject<List<LotteryResListListBean>> _lotteryHistoryController =
  BehaviorSubject<List<LotteryResListListBean>>();

  Sink<List<LotteryResListListBean>> get _lotteryHistorySink =>
      _lotteryHistoryController.sink;

  Stream<List<LotteryResListListBean>> get lotteryHistoryStream =>
      _lotteryHistoryController.stream;

  // 开奖详情
  BehaviorSubject<LotteryResultBean> _lotteryController =
  BehaviorSubject<LotteryResultBean>();

  Sink<LotteryResultBean> get _lotterySink => _lotteryController.sink;

  Stream<LotteryResultBean> get lotteryStream => _lotteryController.stream;

  /// 获取开奖列表
  getLotteryInfo() =>
      ApiRepository.getInstance().queryLotteryList().doOnDone(() {
        print("doOnDone");
      }).doOnListen(() {
        print("doOnListen");
      }).doOnError((error, stacktrace) {
        if (error is DioError) {
          Utils.showToast("加载失败，请检查网络连接");
        }
      }).listen((onData) {
        // {"resultcode":"112","reason":"超过每日可允许请求次数!","result":null,"error_code":10012}
        bool isSuccess = true;
        for (final data in onData) {
          var result = data.data['result'];
          if (result == null) {
            isSuccess = false;
            break;
          }
        }
        if (isSuccess) {
          List<LotteryInfo> lotteryList = onData.map((data) {
            var result = data.data['result'];
            return LotteryInfo(
                lotteryId: result['lottery_id'],
                lotteryName: result['lottery_name'],
                lotteryNo: result['lottery_no'],
                lotteryDate: result['lottery_date'],
                lotteryRes: result['lottery_res']);
          }).toList();
          _lotteryInfoSink.add(lotteryList);
        } else {
          _lotteryInfoSink.add(List<LotteryInfo>());
        }
      });

  List<LotteryResListListBean> _historyList;

  Future refreshHistory(String lotteryId) async {
    await getLotteryHistory(lotteryId, 1);
    return;
  }

  /// 获取开奖历史列表
  getLotteryHistory(String lotteryId, int pageIndex) {
    if (_historyList == null) {
      _historyList = new List();
    }
    if (pageIndex == 1) {
      _historyList.clear();
    }
    ApiRepository.getInstance().history(lotteryId, pageIndex).doOnDone(() {
      print("doOnDone");
    }).doOnListen(() {
      print("doOnListen");
    }).doOnError((error, stacktrace) {
      if (error is DioError) {
        Utils.showToast("加载失败，请检查网络连接");
      }
    }).listen((onData) {
      LotteryHistory lotteryHistory = LotteryHistory.fromJson(onData.data);
      var resultBean = lotteryHistory.result;
      if (resultBean != null && resultBean.lotteryResList.isNotEmpty) {
        _historyList.addAll(resultBean.lotteryResList);
        _lotteryHistorySink
            .add(UnmodifiableListView<LotteryResListListBean>(_historyList));
      } else {
        _lotteryHistorySink.add(new List<LotteryResListListBean>());
      }
    });
  }

  getLotteryDetail(String lotteryId, String lotteryNo) {
    ApiRepository.getInstance().queryLottery(lotteryId, lotteryNo).doOnDone(() {
      print("doOnDone");
    }).doOnListen(() {
      print("doOnListen");
    }).doOnError((error, stacktrace) {
      if (error is DioError) {
        Utils.showToast("加载失败，请检查网络连接");
      }
    }).listen((onData) {
      Lottery lottery = Lottery.fromJson(onData.data);
      if (lottery != null && lottery.result != null) {
        _lotterySink.add(lottery.result);
      }
    });
  }

  @override
  void dispose() {
    _lotteryInfoController.close();
    _lotteryController.close();
    _lotteryHistoryController.close();
  }
}
