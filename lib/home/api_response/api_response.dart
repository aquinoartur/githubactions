import 'package:githubactions/core/error/app_error.dart';

sealed class ApiResponse<T> {
  ApiResponse();

  factory ApiResponse.success(T data) {
    return Success(data: data);
  }
  factory ApiResponse.error(AppErrorType error) {
    return ErroResponse(error: error);
  }
}

class Success<T> extends ApiResponse<T> {
  final T data;

  Success({
    required this.data,
  });
}

class ErroResponse<T> extends ApiResponse<T> {
  final AppErrorType error;
  ErroResponse({
    required this.error,
  });
}
