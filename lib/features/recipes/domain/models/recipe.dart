import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final List<String> directions;
  final List<String> ingredients;
  final String language;
  final String source;
  final List<String> tags;
  final String title;
  final String url;
  final String id;

  const Recipe({
    required this.directions,
    required this.ingredients,
    required this.language,
    required this.source,
    required this.tags,
    required this.title,
    required this.url,
    required this.id,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      directions: json['directions'] ?? [],
      ingredients: json['ingredients'] ?? [],
      language: json['language'] ?? '',
      source: json['source'] ?? '',
      tags: json['tags'] ?? [],
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'directions': directions,
      'ingredients': ingredients,
      'language': language,
      'source': source,
      'tags': tags,
      'title': title,
      'url': url,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [id];
}
