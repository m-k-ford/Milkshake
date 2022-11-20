import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:milkshake/features/user/domain/auth/authenticator.dart';
import 'package:milkshake/features/user/domain/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Authenticator auth;
  UserBloc({required this.auth}) : super(Empty()) {
    on<GetUserEvent>((event, emit) async {
      final result = await auth.getCurrentUser();
      emit(result.fold(
        (failure) => SignedOut(),
        (user) => SignedIn(user: user),
      ));
    });
  }
}
