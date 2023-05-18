import 'package:learning_mvvm/data/network/base_api_service.dart';
import 'package:learning_mvvm/data/network/network_api_service.dart';
import 'package:learning_mvvm/res/app_url.dart';

class AuthRepo {
  /* 
  "NetworkApiService" is a subclass of "BaseApiService", it inherits all of the properties and methods 
  of the abstract base class. When we create an instance of "NetworkApiService" and assign it to a variable 
  of type "BaseApiService", we can still access all of the methods defined in the "NetworkApiService" 
  class because it has already implemented all of the abstract methods defined in the BaseApiService class. 
  This is possible because of the concept of polymorphism in object-oriented programming, 
  where objects of a derived class can be treated as objects of the base class.
  */
  BaseApiService _apiService = NetworkApiService();

/* 
we can directly do this work like:

        NetworkApiService _apiService = NetworkApiService();

But, using the abstract base class "BaseApiService" to define "_apiService" allows us to have the flexibility 
to switch out the implementation of "BaseApiService" with other classes that extend it, without having to change 
the code that uses "_apiService".

For example, if we decide to switch to a different API service implementation, we can simply create a new class 
that extends "BaseApiService" and update the "_apiService" variable to use that new class. This allows us to write 
more modular and extensible code. Like: 

        _apiService = anotherInheritedApiService();
*/
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.login, data);
      return response;
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.signUp, data);
      return response;
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }
}
