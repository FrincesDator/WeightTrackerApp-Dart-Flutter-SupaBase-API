import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeSearchPage extends StatefulWidget {
  @override
  _RecipeSearchPageState createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _recipes = [];

  Future<void> _searchRecipes(String query) async {
    final String apiKey = 'd293941af3d8419d97ed8449f7c0c83b';
    final String apiUrl = 'https://api.spoonacular.com/recipes/complexSearch';

    final response = await http.get(
      Uri.parse('$apiUrl?number=20&query=$query&apiKey=$apiKey'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _recipes = json.decode(response.body)['results'];
      });
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> _showIngredients(int recipeId) async {
    final String apiKey = 'd293941af3d8419d97ed8449f7c0c83b';
    final String apiUrl = 'https://api.spoonacular.com/recipes/$recipeId/information';

    final response = await http.get(
      Uri.parse('$apiUrl?apiKey=$apiKey'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> recipeDetails = json.decode(response.body);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ingredients'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var ingredient in recipeDetails['extendedIngredients'])
                  Text('- ${ingredient['original']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\t\t\t\tSEARCH RECIPE ID',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFfe5d26),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'ENTER FOOD (EX. CHICKEN)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchRecipes(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _recipes.isNotEmpty
                  ? ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Dish: ${_recipes[index]['title']}',
                    ),
                    onTap: () {
                      _showIngredients(_recipes[index]['id']);
                    },
                  );
                },
              )
                  : Center(
                child: Text('No recipes found.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
