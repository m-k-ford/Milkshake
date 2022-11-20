import 'package:milkshake/core/utilities/network_info.dart';
import 'package:milkshake/features/recipes/data/recipes_data_source.dart';
import 'package:milkshake/features/recipes/domain/models/recipe.dart';
import 'package:milkshake/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:milkshake/features/recipes/domain/models/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final NetworkInfo networkInfo;
  final RecipesDataSource dataSource;

  const RecipeRepositoryImpl({
    required this.networkInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, dynamic>> create(Recipe recipeToCreate) async {
    try {
      final isOnline = await networkInfo.hasConnection();
      await dataSource.upload(isOnline, recipeToCreate);
      return Right(recipeToCreate);
    } on Exception catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> read() async {
    try {
      final isOnline = await networkInfo.hasConnection();
      final result = await dataSource.fetch(isOnline);
      return Right(result);
    } on Exception catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> update(Recipe recipeToUpdate) async {
    try {
      final isOnline = await networkInfo.hasConnection();
      await dataSource.upload(isOnline, recipeToUpdate);
      return Right(recipeToUpdate);
    } on Exception catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> delete(Recipe recipeToDelete) async {
    try {
      final isOnline = await networkInfo.hasConnection();
      await dataSource.delete(isOnline, recipeToDelete);
      return const Right(null);
    } on Exception catch (_) {
      return Left(GeneralFailure());
    }
  }
}
