import 'package:dio/dio.dart';
import 'package:githubactions/core/error/app_error.dart';
import 'package:githubactions/home/api_response/api_response.dart';
import 'package:githubactions/main.dart';

import '../model/user_model.dart';

class MockRepository implements HomeRepository {
  @override
  Future<ApiResponse<UserModel>> getTestData(String termo) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      data: UserModel(
        name: 'Mock User',
        login: 'mockuser',
        avatarUrl: 'https://example.com/avatar.png',
        blog: '',
      ),
    );
  }

  @override
  Dio get dio => throw UnimplementedError();
}

class HomeRepository {
  final Dio dio;

  HomeRepository({
    required this.dio,
  });

  Future<ApiResponse<UserModel>> getTestData(String termo) async {
    try {
      if (termo.isEmpty) {
        return ErroResponse(
          error: ValidationError('Termo vazio'),
        );
      } else {
        dio.options.headers.addAll(
          {
            'Authorization': 'token $appToken',
            'Accept': 'application/vnd.github.v3+json',
          },
        );

        final response = await dio.get('https://api.github.com/user');

        if (response.statusCode == 200) {
          final model = UserModel.fromMap(response.data);

          return Success<UserModel>(data: model);
        } else {
          return ErroResponse(
            error: HttpError('Erro desconhecido'),
          );
        }
      }
    } on DioException catch (error) {
      return ErroResponse(
          error: HttpError(
        errorHandler(error) ?? '',
      ));
    }
  }
}

String? errorHandler(DioException e) {
  switch (e.response?.statusCode) {
    case 400:
      return e.message;
    case 401:
      print('Unauthorized: ${e.response?.data}');
      break;
    case 403:
      print('Forbidden: ${e.response?.data}');
      break;
    case 404:
      return e.message;

    case 500:
      print('Internal Server Error: ${e.response?.data}');
      break;
    default:
      print('Error: ${e.message}');
  }
  return null;
}
