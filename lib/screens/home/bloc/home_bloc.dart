import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_supabase/core/connectivity.dart';
import 'package:project_supabase/services/database_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<DataRequested>(getData);
    on<DataPost>(postData);
  }
  FutureOr<void> getData(DataRequested event, Emitter<HomeState> emit) async {
    try {
      final bool isConnected = await checkConnectivity();
      emit(HomeLoading());
      if (isConnected) {
        var fetchTodo = await DatabaseServices().fetchTodo();

        if (fetchTodo!.isEmpty) {
          emit(HomeInitial());
        } else {
          emit(HomeGetData(value: fetchTodo));
        }
      } else {
        emit(HomewithNoInternet());
      }
    } catch (e) {
      emit(HomeError());
    }
  }

  FutureOr<void> postData(DataPost event, Emitter<HomeState> emit) async {
    try {
      final bool isConnected = await checkConnectivity();

      if (isConnected) {
        var fetchTodo = await DatabaseServices()
            .addTodo(title: event.title, description: event.description);

        if (fetchTodo == null) {
          emit(HomeDataPostedSuccesfully());
        } else {
          emit(HomeDataPostedUnSuccesfully(message: ''));
        }
      } else {
        emit(HomewithNoInternet());
      }
    } on PostgrestException catch (s) {
      emit(HomeDataPostedUnSuccesfully(message: s.message));
    } catch (e) {
      emit(HomeError());
    }
  }
}
