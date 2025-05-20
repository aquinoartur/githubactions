import 'package:githubactions/home/model/user_model.dart';

sealed class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState(this.error);
}

class HomeSuccessState extends HomeState {
  final UserModel userModel;

  HomeSuccessState(this.userModel);
}

class HomeEmptyState extends HomeState {}

class HomeInitialState extends HomeState {}
