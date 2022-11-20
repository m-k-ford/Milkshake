import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:milkshake/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:milkshake/features/user/data/data_source.dart';
import 'package:milkshake/features/user/domain/auth/authenticator.dart';
import 'package:milkshake/features/user/domain/models/user.dart';

class AuthenticatorImpl implements Authenticator {
  final UserDataSource dataSource;
  final auth.FirebaseAuth firebaseAuth;

  const AuthenticatorImpl({
    required this.dataSource,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      final user = await dataSource.fetch(firebaseUser.uid);
      return Future.value(Right(user));
    } else {
      return Future.value(Left(GeneralFailure()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = User(
        id: result.user!.uid,
        name: name,
        email: result.user!.email!,
      );

      await dataSource.upload(user);
      return Right(user);
    } on auth.FirebaseAuthException catch (_) {
      print('Authenticator error in signUp!');
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await dataSource.fetch(result.user!.uid);
      return Right(user);
    } on auth.FirebaseAuthException catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> singOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } on auth.FirebaseAuthException catch (_) {
      return Left(GeneralFailure());
    }
  }
}
