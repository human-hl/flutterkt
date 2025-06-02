import 'package:go_router/go_router.dart';
import 'package:coffee_recipe_app/features/recipes/recipe_list_screen.dart';
import 'package:coffee_recipe_app/features/recipes/recipe_detail_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RecipeListScreen(),
      ),
      GoRoute(
        path: '/recipe/:id',
        builder: (context, state) =>
            RecipeDetailScreen(recipeId: state.pathParameters['id']!),
      ),
    ],
  );
}
