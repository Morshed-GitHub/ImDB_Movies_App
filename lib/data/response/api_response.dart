import 'package:learning_mvvm/data/response/status.dart';

class ApiResponse<T> {
  // Parameterized Class (Generick Class)
  final Status? status;
  T? data;
  String? message;

  // Parameterized Constructor
  ApiResponse([this.status, this.data, this.message]);

  // Named Constructor
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  /*
  The toString() method is defined in the Object class which is the root of the Dart object hierarchy. 
  Every class in Dart implicitly inherits from Object. Therefore, if you don't override the toString() 
  method in your class, it will use the default implementation provided by the Object class.

  If we override this method, then it will safe us from the unwanted bug hassel.
  */

  @override
  String toString() {
    return "Status: $status\n Error: $message\n Data: $data";
  }
}
