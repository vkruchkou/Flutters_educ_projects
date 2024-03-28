import 'package:flutter/material.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_delail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.pink,
            onPrimary: Colors.white,
            secondary: Colors.amber,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.green,
            surface: Color.fromRGBO(255, 254, 229, 1),
            onSurface: Colors.black),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyMedium: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleMedium: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDelailScreen.routeName: (ctx) => const MealDelailScreen()
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
