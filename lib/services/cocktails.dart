import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

typedef CocktailList = List<Cocktail>;

class Cocktail {
  Cocktail({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
  bool alcoholic = false;
  String instructions = "";
  String photo = "";
  List<String> ingredients = [];
}

class CocktailService {
  Future<CocktailList> getList() async {
    CocktailList result = [];
    final response = await http.get(Uri.parse("http://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<dynamic> cocktails = jsonMap['drinks'];

      cocktails.forEach((cocktail) {
        result.add(Cocktail(id: cocktail['idDrink'], name: cocktail['strDrink']));
      });
    }

    return result;
  }

  Future<Cocktail> getById(String id) async {
    Cocktail result = Cocktail(name: "", id: id);
    final response = await http.get(Uri.parse("http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id")).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      var cocktails = jsonMap['drinks'];
      var cocktail = cocktails[0];

      result = Cocktail(name: cocktail['strDrink'], id: id);
      result.alcoholic = cocktail['strAlcoholic'] == "Alcoholic";
      result.instructions = cocktail['strInstructions'] ?? "";
      result.photo = cocktail['strDrinkThumb'] ?? "";

      for (var i = 1; i < 15; i++) {
        if (cocktail['strIngredient$i'] != null) {
          result.ingredients.add(cocktail['strIngredient$i']);
        }
      }
    }

    return result;
  }
}
