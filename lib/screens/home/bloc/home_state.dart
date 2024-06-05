part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeGetData extends HomeState {
  final List<Map<String, dynamic>> value;

  HomeGetData({required this.value});
}

final class HomePostData extends HomeState {}

final class HomeDataPostedSuccesfully extends HomeState {}

final class HomeDataPostedUnSuccesfully extends HomeState {
  final String message;

  HomeDataPostedUnSuccesfully({required this.message});
}

final class HomeWithNoData extends HomeState {}

final class HomewithNoInternet extends HomeState {}

final class HomeError extends HomeState {}
