import 'package:flutter/material.dart';

import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../model/movies_ilst_model.dart';
import '../res/app_url.dart';

class HomeRepo {
  BaseApiService _apiService = NetworkApiService();

  Future<MoviesListModel> fetchMoviesList() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(AppUrl.moviesList);
      debugPrint("Api Hitted");
      return MoviesListModel.fromJson(response);
    } catch (exception) {
      throw exception.toString();
    }
  }
}
