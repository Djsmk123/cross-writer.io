import 'dart:convert';
import 'dart:developer';

import 'package:blogtools/core/Model/api_response_model.dart';
import 'package:blogtools/core/errors/exceptions.dart';
import 'package:blogtools/core/errors/failures.dart';
import 'package:blogtools/core/services/network/network_util.dart';
import 'package:blogtools/core/utils/json_parser.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  static var url = "https://cross-writer-io.onrender.com/api/v2";
  //static var url = "http://localhost:8080/api/v2";
  Future<bool> get isConnected;

  Future<(Failure?, ApiResponseModel?)> getRequest({
    required String endpoint,
    HttpParam? params,
    HttpHeader? header,
    QueryParam? queryParam,
  });
  Future<(Failure?, ApiResponseModel?)> postRequest({
    required String endpoint,
    QueryParam? params,
    HttpHeader? header,
    required Map<String, dynamic> body,
  });
}

class NetworkInfoImpl extends NetworkInfo with JsonParsers {
  InternetConnectionCheckerPlus connectionChecker =
      InternetConnectionCheckerPlus();

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future<(Failure?, ApiResponseModel?)> getRequest(
      {required String endpoint,
      HttpParam? params,
      HttpHeader? header,
      QueryParam? queryParam}) async {
    final isConnected = await connectionChecker.hasConnection;
    try {
      if (isConnected) {
        var uri = Uri.parse("${NetworkInfo.url}$endpoint");
        if (queryParam != null) {
          uri = uri.replace(queryParameters: queryParam.params);
        }
        log(uri.toString(), name: 'uri');
        header ??= HttpHeader();
        final response = await http.get(uri, headers: header.headers);
        final data = parseJson(response.body.toString());

        if (data.$1 != null) {
          return (data.$1, null);
        }
        final ApiResponseModel apiResponseModel =
            ApiResponseModel.fromJson(data.$2);
        return (null, apiResponseModel);
      }
    } catch (e) {
      log(e.toString());
    }
    return (ServerFailure(), null);
  }

  @override
  Future<(Failure?, ApiResponseModel?)> postRequest(
      {required String endpoint,
      QueryParam? params,
      HttpHeader? header,
      required Map<String, dynamic> body}) async {
    try {
      final isConnected = await connectionChecker.hasConnection;
      if (isConnected) {
        var uri = Uri.parse("${NetworkInfo.url}$endpoint");
        if (params != null) {
          uri = uri.replace(queryParameters: params.params);
        }
        log(uri.toString());
        header ??= HttpHeader();
        log(jsonEncode(body.toString()), name: "body");
        http.Response response = await http
            .post(uri, headers: header.headers, body: jsonEncode(body))
            .timeout(const Duration(seconds: 30), onTimeout: () {
          return http.Response(jsonEncode({'Error': "Timeout"}), 500);
        });
        final data = parseJson(response.body.toString());
        if (data.$1 != null) {
          return (data.$1, null);
        }

        final ApiResponseModel apiResponseModel =
            ApiResponseModel.fromJson(data.$2);
        if (apiResponseModel.error != null) {
          return (
            EndpointFailure(message: apiResponseModel.error ?? "Server error"),
            null
          );
        }
        return (null, apiResponseModel);
      }
    } catch (e) {
      log(e.toString());
    }
    return (ServerFailure(), null);
  }
}
