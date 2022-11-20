import 'package:dartz/dartz.dart';
import 'package:milkshake/core/errors/failures.dart';
import 'package:milkshake/features/recipes/domain/models/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, dynamic>> create(Recipe recipeToCreate);
  Future<Either<Failure, List<Recipe>>> read();
  Future<Either<Failure, dynamic>> update(Recipe recipeToUpdate);
  Future<Either<Failure, dynamic>> delete(Recipe recipeToDelete);
}
