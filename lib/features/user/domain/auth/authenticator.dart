import 'package:dartz/dartz.dart';
import 'package:milkshake/core/errors/failures.dart';
import 'package:milkshake/features/user/domain/models/user.dart';

abstract class Authenticator {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, dynamic>> singOut();
}
