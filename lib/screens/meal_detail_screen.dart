// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                selectMeal.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        selectMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(mealId),
        child: Icon(Icons.delete),
      ),
    );
  }
}
