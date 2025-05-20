import 'package:flutter/material.dart';
import 'package:githubactions/core/error/app_error.dart';
import 'package:githubactions/home/api_response/api_response.dart';
import 'package:githubactions/home/repository/home_repository.dart';
import 'package:githubactions/home/store/home_state.dart';

class HomeStore extends ValueNotifier<HomeState> {
  final HomeRepository _homeRepository;
  HomeStore(
    this._homeRepository,
  ) : super(HomeInitialState());

  // final HomeRepository _homeRepository = HomeRepository(
  //   dio: Dio(),
  // );

  Future<void> loadData() async {
    value = HomeLoadingState();

    final response = await _homeRepository.getTestData('teste');

    switch (response) {
      case Success(data: var userModel):
        value = HomeSuccessState(userModel);

      case ErroResponse(error: var error):
        if (error is ValidationError) {
          value = HomeErrorState(error.message);
        }
        if (error is HttpError) {
          value = HomeErrorState(error.message);
        }

      default:
        value = HomeEmptyState();
    }
  }
}
