import 'dart:convert';
import 'dart:io';
import 'package:learning_mvvm/data/exceptions.dart';
import 'package:learning_mvvm/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

// Now don't have to create http get & post service for every API

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      BadRequestException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException("400");
      case 404:
        throw UnauthorisedException("404");
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server with status code ${response.statusCode.toString()}');
    }
  }
}
