part of 'home_bloc.dart';

sealed class HomeEvent {}

class DataRequested extends HomeEvent {}

class DataPost extends HomeEvent {
  final String title;
  final String description;

  DataPost(this.title, this.description);
}
