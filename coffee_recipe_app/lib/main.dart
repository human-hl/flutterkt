import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_recipe_app/core/app_router.dart';
import 'package:coffee_recipe_app/core/theme/app_theme.dart';
import 'package:coffee_recipe_app/features/recipes/recipe_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
      ],
      child: MaterialApp.router(
        title: 'Coffee Recipes',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
