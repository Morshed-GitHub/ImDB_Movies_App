import 'package:flutter/material.dart';
import 'package:learning_mvvm/data/response/api_response.dart';
import 'package:learning_mvvm/model/movies_ilst_model.dart';
import 'package:learning_mvvm/repo/home_repo.dart';

class HomeViewModel with ChangeNotifier {
  ApiResponse<MoviesListModel> _apiResponse = ApiResponse.loading();
  HomeRepo _homeRepo = HomeRepo();

  ApiResponse<MoviesListModel> get apiResponse => _apiResponse;

  Future<void> fetchMoviesList() async {
    _setApiResponse(ApiResponse.loading());

    try {
      final value = await _homeRepo.fetchMoviesList();
      _setApiResponse(ApiResponse.completed(value));
      debugPrint('Fetched Movies');
    } catch (error) {
      debugPrint('Error Occured');
      debugPrint(error.toString());
      _setApiResponse(ApiResponse.error(error.toString()));
    }
  }

  void _setApiResponse(ApiResponse<MoviesListModel> response) {
    _apiResponse = response;
    notifyListeners();
  }
}
