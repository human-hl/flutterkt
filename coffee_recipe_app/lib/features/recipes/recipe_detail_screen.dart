import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_recipe_app/features/recipes/recipe_provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({Key? key, required this.recipeId})
      : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    recipeProvider.loadRecipeById(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    if (recipeProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final recipe = recipeProvider.selectedRecipe;

    if (recipe == null) {
      return const Scaffold(body: Center(child: Text('Recipe not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(height: 16),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...recipe.ingredients
                  .map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '• $ingredient',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 16),
              Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...recipe.instructions.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final instruction = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '$index. $instruction',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
