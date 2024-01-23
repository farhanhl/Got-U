import 'package:dio/dio.dart';

const baseUrlIpInfo = "https://ipinfo.io";
const tokenIpInfo = "9c65c6f0009eee";
const baseUrlQuotes = "https://api.quotable.io";
const baseUrlIpify = "https://api.ipify.org?format=json";

class Api {
  final Dio dioIpInfo = Dio(
    BaseOptions(
      baseUrl: baseUrlIpInfo,
      contentType: 'application/json',
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );
  final Dio dioQuotes = Dio(
    BaseOptions(
      baseUrl: baseUrlQuotes,
      contentType: 'application/json',
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );
  final Dio dioIpify = Dio(
    BaseOptions(
      baseUrl: baseUrlIpify,
      contentType: 'application/json',
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );

  Future<Response> getIpData(String ip) {
    return dioIpInfo.get(
      "/$ip/json?token=$tokenIpInfo",
    );
  }

  Future<Response> getQuotesData() => dioQuotes.get("/quotes/random");

  Future<Response> getIpAddress() => dioIpify.get("?format=json");
}
