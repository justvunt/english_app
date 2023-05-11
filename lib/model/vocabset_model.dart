class VocabSet {
  String? id;
  String? createTime;
  int? times;
  String? nickname;

  VocabSet({this.id, this.createTime, this.times, this.nickname});

  VocabSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    times = json['times'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['times'] = this.times;
    data['nickname'] = this.nickname;
    return data;
  }
}