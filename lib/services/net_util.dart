import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:technical_take_home/helper/app_exception.dart';
import 'package:technical_take_home/helper/constant.dart';

class NetworkUtil {
  static NetworkUtil instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => instance;
  Future<dynamic> get(
    String url, {
    Map<String, String>? param,
    Map<String, String>? headers,
  }) {
    Map<String, String> paramFinal = {
      "api_key": Constant.apiKey,
    };
    if (param != null) {
      paramFinal.addAll(param);
    }
    return http.get(_setParameter(url, paramFinal), headers: headers).then((http.Response response) => _returnResponse(response));
  }

  Future<dynamic> getImage(
    String url, {
    Map<String, String>? param,
    Map<String, String>? headers,
  }) {
    return http.get(_setParameter(url, param), headers: headers).then((http.Response response) => _returnResponseImage(response));
  }

  dynamic _returnResponseImage(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson;

        responseJson = response.body;

        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        throw BadRequestException(responseJson['message']);
      case 401:
        throw InvalidSessionExpression('Response 401');
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        var responseJson = json.decode(response.body.toString());
        throw FetchDataException(responseJson['message']);
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> responseJson = {};
        var responseHeader = response.headers;
        responseJson.addAll(responseHeader);

        late Map<String, dynamic> responseBody;
        try {
          responseBody = json.decode(response.body);
        } catch (e) {
          throw FetchDataException('Successfully requested, but an invalid response retrieved');
        }

        responseJson.addAll(responseBody);

        return responseJson;
      case 400:
        throw BadRequestException('Error 400');
      case 401:
        throw InvalidSessionExpression('Response 401');
      case 403:
        throw UnauthorisedException(response.headers.toString());
      case 422:
        throw InvalidInputException(response.body);
      case 500:
        Map responseJson = {};
        responseJson.addAll(response.headers);
        var responseBody = json.decode(response.body);
        responseJson.addAll(responseBody);
        var message = responseJson['message'];
        throw FetchDataException('Error 500 : $message');
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Uri _setParameter(String url, Map<String, dynamic>? param) {
    int count = 0;
    if (param != null) {
      if (!url.endsWith('?')) {
        url = url + '?';
      }
      param.forEach((key, value) {
        if (count == 0) {
          url = url + key + '=$value';
          count++;
        } else {
          url = url + '&' + key + '=$value';
        }
      });
    }
    return Uri.parse(url);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
