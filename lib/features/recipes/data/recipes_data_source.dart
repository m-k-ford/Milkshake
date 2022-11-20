import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milkshake/core/constants/strings.dart';
import 'package:milkshake/core/utilities/network_info.dart';
import 'package:milkshake/features/recipes/domain/models/recipe.dart';

abstract class RecipesDataSource {
  Future<List<Recipe>> fetch(bool isOnline);
  Future upload(bool isOnline, Recipe recipeToUpload);
  Future delete(bool isOnline, Recipe recipeToDelete);
}

class RecipesDataSourceImpl implements RecipesDataSource {
  final NetworkInfo networkInfo;
  final FirebaseFirestore firestore;

  const RecipesDataSourceImpl({
    required this.networkInfo,
    required this.firestore,
  });

  Future _toggleNetwork() async {
    if (await networkInfo.hasConnection()) {
      await firestore.enableNetwork();
    } else {
      await firestore.disableNetwork();
    }
  }

  @override
  Future<List<Recipe>> fetch(bool isOnline) async {
    try {
      await _toggleNetwork();
      final result = await firestore.collection(recipes).get();
      return result.docs.map((json) => Recipe.fromJson(json.data())).toList();
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future delete(bool isOnline, Recipe recipeToDelete) async {
    try {
      await _toggleNetwork();
      await firestore.collection(recipes).doc(recipeToDelete.id).delete();
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future upload(bool isOnline, Recipe recipeToUpload) async {
    try {
      await _toggleNetwork();
      await firestore
          .collection(recipes)
          .doc(recipeToUpload.id)
          .set(recipeToUpload.toJson());
      return recipeToUpload;
    } catch (_) {
      throw Exception();
    }
  }
}
