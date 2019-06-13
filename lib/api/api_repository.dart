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

  /**
   *  历史开奖记录
   */
  Observable<dynamic> history(String lotteryId, int pageIndex) {
    Observable baseResp = Observable.fromFuture(
        _dio.get(Api.LOTTERY_HISTORY, queryParameters: {
          "lottery_id": lotteryId,
          "page_size": Api.PAGE_SIZE,
          "page": pageIndex,
          "key": Api.KEY
        }));
    return baseResp;
  }

  Future<Response> lottery(String lotteryId) {
    return _dio.get(Api.LOTTERY_QUERY, queryParameters: {
      "lottery_id": lotteryId,
      "lottery_no": "",
      "key": Api.KEY
    });
  }

  Future queryLotteryList_() {
    Future<List<Response>> resp = Future.wait([
      lottery(Const.SSQ),
      lottery(Const.DLT),
      lottery(Const.QLC),
      lottery(Const.QXC),
      lottery(Const.PLS),
      lottery(Const.PLW),
      lottery(Const.FCSD),
    ]);
    return resp;
  }
}
