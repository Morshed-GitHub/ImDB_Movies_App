class AppUrl {
  static const String baseUrl = "https://reqres.in/";
  static const String login = "${baseUrl}api/login";
  static const String signUp = "${baseUrl}api/register";

  static const String moviesListBaseUrl = "https://imdb-api.com/en/API/";

  // Note: Must provide API_KEY
  static const String _moviesListApiKey = "API_KEY";
  static const String moviesList =
      "${moviesListBaseUrl}Top250Movies/${_moviesListApiKey}";
}
