class IpifyModel {
  String? ip;

  IpifyModel({this.ip});

  IpifyModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ip'] = ip;
    return data;
  }
}
