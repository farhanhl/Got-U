import 'package:dio/dio.dart';
import 'package:got_u_app/app/core/providers/api.dart';
import '../../../data/models/quotes_model.dart';
import '../../../data/models/ip_info_model.dart';

class HomeService {
  Api api;
  HomeService(this.api);

  Future<IpInfo> getIpData(String ip) {
    return api.getIpData(ip).then((value) {
      return IpInfo.fromJson(value.data);
    }).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError
              ? (e as DioError).error
              : "Something went wrong: $e",
        );
      },
    );
  }

  Future<QuotesModel> getQuotesData() {
    return api.getQuotesData().then((value) {
      return QuotesModel.fromJson(value.data[0]);
    }).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError
              ? (e as DioError).error
              : "Something went wrong: $e",
        );
      },
    );
  }

  Future<String> getIpAddress() {
    return api.getIpAddress().then((value) {
      return value.data.toString();
    }).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError
              ? (e as DioError).error
              : "Something went wrong: $e",
        );
      },
    );
  }
}
