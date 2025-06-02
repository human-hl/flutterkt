import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coffee_recipe_app/features/recipes/recipe.dart';

class RecipeRepositoryImpl {
  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=coffee'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('drinks') && data['drinks'] is List<dynamic>) {
          final List<dynamic> drinks = data['drinks'] as List<dynamic>;
          final List<Recipe> recipes = [];

          for (var i = 0; i < drinks.length && i < 10; i++) {
            final drink = drinks[i];
            final recipeId = drink['idDrink'] as String?;
            if (recipeId != null) {
              final recipeDetails = await getRecipeDetails(recipeId);
              if (recipeDetails != null) {
                recipes.add(recipeDetails);
              }
            }
          }
          return recipes;
        } else {
          print('No coffee recipes found.');
          return [];
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        throw Exception(
            'Failed to load recipes. Status code: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('Network error: $e');
      throw Exception('Network error: Check your internet connection.');
    } catch (e) {
      print('Error fetching recipes: $e');
      rethrow;
    }
  }

  Future<Recipe?> getRecipeDetails(String id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('drinks') &&
            data['drinks'] is List<dynamic> &&
            (data['drinks'] as List).isNotEmpty) {
          final drink = (data['drinks'] as List<dynamic>)[0];

          final List<String> ingredients = [];
          final List<String> instructions = [];

          for (var i = 1; i <= 15; i++) {
            final ingredient = drink['strIngredient$i'] as String?;
            final measure = drink['strMeasure$i'] as String?;
            if (ingredient != null && ingredient.isNotEmpty) {
              ingredients.add('${measure ?? ''} ${ingredient.trim()}'.trim());
            }
          }

          String? instructionsText = drink['strInstructions'];
          if (instructionsText != null) {
            instructions.addAll(instructionsText
                .split('\r\n')
                .where((s) => s.trim().isNotEmpty)
                .toList());
          }

          return Recipe(
            id: drink['idDrink'] as String,
            name: drink['strDrink'] as String,
            imageUrl: drink['strDrinkThumb'] as String,
            ingredients: ingredients,
            instructions: instructions,
          );
        }
      }
    } catch (e) {
      print('Error fetching recipe details for ID $id: $e');
    }
    return null;
  }
}
