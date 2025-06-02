import 'package:flutter/material.dart';
import 'package:coffee_recipe_app/features/recipes/recipe.dart';
import 'package:coffee_recipe_app/features/recipes/recipe_repository_impl.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeRepositoryImpl _recipeRepository = RecipeRepositoryImpl();

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  Recipe? _selectedRecipe;
  Recipe? get selectedRecipe => _selectedRecipe;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RecipeProvider() {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    _isLoading = true;
    notifyListeners();
    try {
      _recipes = await _recipeRepository.getRecipes();
    } catch (e) {
      print('Error loading recipes in RecipeProvider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRecipeById(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedRecipe = await _recipeRepository.getRecipeDetails(id);
    } catch (e) {
      print('Error loading recipe by id: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
