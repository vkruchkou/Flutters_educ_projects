import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDelailScreen extends StatelessWidget {
  const MealDelailScreen({super.key});

  static const routeName = '/meal-detail';

  Widget buildSectionTilte(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => mealId == element.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title:
            FittedBox(fit: BoxFit.scaleDown, child: Text(selectedMeal.title)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTilte(context, 'Ingredients'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index])),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectionTilte(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            )),
          ],
        ),
      ),
    );
  }
}
