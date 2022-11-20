import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milkshake/core/constants/strings.dart';
import 'package:milkshake/core/utilities/network_info.dart';
import 'package:milkshake/features/user/domain/models/user.dart';

abstract class UserDataSource {
  /// returns a [User] from the data source
  ///
  /// throws an exception for all errors
  Future<User> fetch(String uid);

  /// uploads a [User] to the data source
  ///
  /// throws an exception for all errors
  Future upload(User userToUpload);
}

class UserDataSourceImpl implements UserDataSource {
  final NetworkInfo networkInfo;
  final FirebaseFirestore firestore;
  const UserDataSourceImpl({
    required this.firestore,
    required this.networkInfo,
  });

  Future _toggleNetwork() async {
    if (await networkInfo.hasConnection()) {
      await firestore.enableNetwork();
    } else {
      await firestore.disableNetwork();
    }
  }

  @override
  Future<User> fetch(String uid) async {
    try {
      await _toggleNetwork();
      final result = await firestore.collection(users).doc(uid).get();
      return User.fromJson(result.data()!);
    } catch (_) {
      print('User data source error in fetch!');
      throw Exception();
    }
  }

  @override
  Future upload(User userToUpload) async {
    try {
      await _toggleNetwork();
      await firestore
          .collection(users)
          .doc(userToUpload.id)
          .set(userToUpload.toJson());
      return userToUpload;
    } catch (_) {
      print('User data source error in upload!');
      throw Exception();
    }
  }
}
