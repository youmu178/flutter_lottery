import 'package:dio/dio.dart';
import 'package:flutter_lottery/api/api.dart';
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

  queryLotteryList() {
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
    resp.then((data) {
      data.forEach((data) {
        var result = data.data['result'];
        print(result['lottery_name']);
        print(result['lottery_no']);
        print(result['lottery_date']);
        print(result['lottery_res']);
      });
    });
  }
}
