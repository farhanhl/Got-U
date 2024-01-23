class IpInfo {
  String? ip;
  String? city;
  String? region;
  String? country;
  String? loc;
  String? org;
  String? timezone;

  IpInfo(
      {this.ip,
      this.city,
      this.region,
      this.country,
      this.loc,
      this.org,
      this.timezone});

  IpInfo.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    loc = json['loc'];
    org = json['org'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ip'] = ip;
    data['city'] = city;
    data['region'] = region;
    data['country'] = country;
    data['loc'] = loc;
    data['org'] = org;
    data['timezone'] = timezone;
    return data;
  }
}
