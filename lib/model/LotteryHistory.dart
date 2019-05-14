class LotteryHistory {
  String reason;
  int errorCode;
  ResultBean result;

  LotteryHistory({this.reason, this.errorCode, this.result});

  LotteryHistory.fromJson(Map<String, dynamic> json) {    
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
  int page;
  int pageSize;
  int totalPage;
  List<LotteryResListListBean> lotteryResList;

  ResultBean({this.page, this.pageSize, this.totalPage, this.lotteryResList});

  ResultBean.fromJson(Map<String, dynamic> json) {    
    this.page = json['page'];
    this.pageSize = json['pageSize'];
    this.totalPage = json['totalPage'];
    this.lotteryResList = (json['lotteryResList'] as List)!=null?(json['lotteryResList'] as List).map((i) => LotteryResListListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['totalPage'] = this.totalPage;
    data['lotteryResList'] = this.lotteryResList != null?this.lotteryResList.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class LotteryResListListBean {
  String lotteryId;
  String lotteryRes;
  String lotteryNo;
  String lotteryDate;
  String lotteryExdate;
  String lotterySaleAmount;
  String lotteryPoolAmount;

  LotteryResListListBean({this.lotteryId, this.lotteryRes, this.lotteryNo, this.lotteryDate, this.lotteryExdate, this.lotterySaleAmount, this.lotteryPoolAmount});

  LotteryResListListBean.fromJson(Map<String, dynamic> json) {    
    this.lotteryId = json['lottery_id'];
    this.lotteryRes = json['lottery_res'];
    this.lotteryNo = json['lottery_no'];
    this.lotteryDate = json['lottery_date'];
    this.lotteryExdate = json['lottery_exdate'];
    this.lotterySaleAmount = json['lottery_sale_amount'];
    this.lotteryPoolAmount = json['lottery_pool_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lottery_id'] = this.lotteryId;
    data['lottery_res'] = this.lotteryRes;
    data['lottery_no'] = this.lotteryNo;
    data['lottery_date'] = this.lotteryDate;
    data['lottery_exdate'] = this.lotteryExdate;
    data['lottery_sale_amount'] = this.lotterySaleAmount;
    data['lottery_pool_amount'] = this.lotteryPoolAmount;
    return data;
  }
}
