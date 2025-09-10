import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SubmitUser>(_onSubmitUser);
  }

  Future<void> _onSubmitUser(
      SubmitUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final response = await http.post(
        Uri.parse("https://68c1a6c198c818a69402a527.mockapi.io/users"), 
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(event.user.toJson()),
      );

      if (response.statusCode == 201) {
        emit(UserSuccess());
      } else {
        emit(UserFailure("Error en la petición: ${response.statusCode}"));
      }
    } catch (e) {
      emit(UserFailure("Excepción: $e"));
    }
  }
}
