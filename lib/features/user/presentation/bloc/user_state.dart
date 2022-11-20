part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class Empty extends UserState {}

class SignedIn extends UserState {
  final User user;
  const SignedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class SignedOut extends UserState {}

class Error extends UserState {}
