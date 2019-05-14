class Lottery {
  String reason;
  int errorCode;
  ResultBean result;

  Lottery({this.reason, this.errorCode, this.result});

  Lottery.fromJson(Map<String, dynamic> json) {    
    this.reason = json['reason'];
    this.errorCode = json['error_code'];
    this.result = json['result'] != null ? ResultBean.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['error_code'] = this.errorCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }

}

class ResultBean {
  String lotteryId;
  String lotteryName;
  String lotteryRes;
  String lotteryNo;
  String lotteryDate;
  String lotteryExdate;
  String lotterySaleAmount;
  String lotteryPoolAmount;
  List<LotteryPrizeListBean> lotteryPrize;

  ResultBean({this.lotteryId, this.lotteryName, this.lotteryRes, this.lotteryNo, this.lotteryDate, this.lotteryExdate, this.lotterySaleAmount, this.lotteryPoolAmount, this.lotteryPrize});

  ResultBean.fromJson(Map<String, dynamic> json) {    
    this.lotteryId = json['lottery_id'];
    this.lotteryName = json['lottery_name'];
    this.lotteryRes = json['lottery_res'];
    this.lotteryNo = json['lottery_no'];
    this.lotteryDate = json['lottery_date'];
    this.lotteryExdate = json['lottery_exdate'];
    this.lotterySaleAmount = json['lottery_sale_amount'];
    this.lotteryPoolAmount = json['lottery_pool_amount'];
    this.lotteryPrize = (json['lottery_prize'] as List)!=null?(json['lottery_prize'] as List).map((i) => LotteryPrizeListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lottery_id'] = this.lotteryId;
    data['lottery_name'] = this.lotteryName;
    data['lottery_res'] = this.lotteryRes;
    data['lottery_no'] = this.lotteryNo;
    data['lottery_date'] = this.lotteryDate;
    data['lottery_exdate'] = this.lotteryExdate;
    data['lottery_sale_amount'] = this.lotterySaleAmount;
    data['lottery_pool_amount'] = this.lotteryPoolAmount;
    data['lottery_prize'] = this.lotteryPrize != null?this.lotteryPrize.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class LotteryPrizeListBean {
  String prizeName;
  String prizeNum;
  String prizeAmount;
  String prizeRequire;

  LotteryPrizeListBean({this.prizeName, this.prizeNum, this.prizeAmount, this.prizeRequire});

  LotteryPrizeListBean.fromJson(Map<String, dynamic> json) {    
    this.prizeName = json['prize_name'];
    this.prizeNum = json['prize_num'];
    this.prizeAmount = json['prize_amount'];
    this.prizeRequire = json['prize_require'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prize_name'] = this.prizeName;
    data['prize_num'] = this.prizeNum;
    data['prize_amount'] = this.prizeAmount;
    data['prize_require'] = this.prizeRequire;
    return data;
  }
}
