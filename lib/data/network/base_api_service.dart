abstract class BaseApiService {
  // Abstract Base Class

  // Contains "abstract functions", which must have to override by those classes, which inherit
  // from this abstract base class.
  Future getGetApiResponse(String url);
  Future getPostApiResponse(String url, dynamic data);
}
