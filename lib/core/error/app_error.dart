sealed class AppErrorType {
  final String message;
  AppErrorType(this.message);
}

class ValidationError extends AppErrorType {
  ValidationError(super.message);
}

class HttpError extends AppErrorType {
  HttpError(super.message);
}
