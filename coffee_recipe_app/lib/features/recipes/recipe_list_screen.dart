import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_recipe_app/features/recipes/recipe.dart';
import 'package:coffee_recipe_app/features/recipes/recipe_provider.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Recipes'),
      ),
      body: recipeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : recipeProvider.recipes.isEmpty && !recipeProvider.isLoading
              ? const Center(
                  child: Text(
                      'Failed to load recipes. Check your internet connection.'))
              : recipeProvider.recipes.isEmpty
                  ? const Center(child: Text('No recipes found.'))
                  : ListView.builder(
                      itemCount: recipeProvider.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = recipeProvider.recipes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0), // Добавляем vertical padding
                          child: RecipeListItem(recipe: recipe),
                        );
                      },
                    ),
    );
  }
}

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  const RecipeListItem({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          context.go('/recipe/${recipe.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipe.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
