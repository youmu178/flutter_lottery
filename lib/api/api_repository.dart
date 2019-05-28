import 'package:dio/dio.dart';
import 'package:flutter_lottery/api/api.dart';
import 'package:flutter_lottery/model/Lottery.dart';
import 'package:flutter_lottery/res/consts.dart';
import 'package:rxdart/rxdart.dart';

class ApiRepository {
  static final ApiRepository _singleton = ApiRepository._init();
  static Dio _dio;

  static ApiRepository getInstance() {
    return _singleton;
  }

  ApiRepository._init() {
    _dio = new Dio();
    _dio.options = new BaseOptions(
      baseUrl: Api.BASE_URL,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Observable<Response<Map<String, dynamic>>> queryLottery(
      String lotteryId, String lotteryNo) {
    Observable<Response<Map<String, dynamic>>> baseResp = Observable.fromFuture(
        _dio.get(Api.LOTTERY_QUERY, queryParameters: {
      "lottery_id": lotteryId,
      "lottery_no": lotteryNo,
      "key": Api.KEY
    }));
    return baseResp;
  }

  /**
   * 获取首页彩票开奖列表
   */
  Observable<List<Response<dynamic>>> queryLotteryList() {
    Observable<List<Response<dynamic>>> baseResp = Observable.fromFuture(
        queryLotteryList_());
    return baseResp;
  }

  Future queryLotteryList_() {
    List<LotteryInfo> lotteryList;
    Future<List<Response>> resp = Future.wait([
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.SSQ,
        "lottery_no": "",
        "key": Api.KEY
      }),
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.DLT,
        "lottery_no": "",
        "key": Api.KEY
      }),
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.QLC,
        "lottery_no": "",
        "key": Api.KEY
      }),
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.QXC,
        "lottery_no": "",
        "key": Api.KEY
      }),
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.PLS,
        "lottery_no": "",
        "key": Api.KEY
      }),
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.PLW,
        "lottery_no": "",
        "key": Api.KEY
      }),
      _dio.get(Api.LOTTERY_QUERY, queryParameters: {
        "lottery_id": Const.FCSD,
        "lottery_no": "",
        "key": Api.KEY
      }),
    ]);
    return resp;
//    resp.then((data) {
//      lotteryList = data.map((data) {
//        var result = data.data['result'];
//        return LotteryInfo(lotteryId: result['lottery_id'],
//            lotteryName: result['lottery_name'],
//            lotteryNo: result['lottery_no'],
//            lotteryDate: result['lottery_date'],
//            lotteryRes: result['lottery_res']);
//      }).toList();
//      return lotteryList;
//    });
  }
}
