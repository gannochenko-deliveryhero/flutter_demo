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

      result = Cocktail(name: cocktails[0]['strDrink'], id: id);
    }

    return result;
  }
}
