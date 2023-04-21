import 'package:flutter/material.dart';

import '../services/cocktails.dart';
import '../util.dart';
import '../widgets/drawer.dart';
import '../widgets/header.dart';
import '../widgets/paragraph.dart';
import '../widgets/list_item.dart';
import '../widgets/exponential_linear_progress_indicator.dart';

class CocktailPage extends StatefulWidget {
  const CocktailPage({
    super.key,
    required this.id,
  });

  final String id;
  final String title = "Cocktail";

  @override
  State<CocktailPage> createState() => CocktailPageState();
}

class CocktailPageState extends State<CocktailPage> {
  Cocktail? _cocktail;
  final CocktailService _cocktailService = CocktailService();

  @override
  void initState() {
    super.initState();
    _loadDevice();
  }

  Future<void> _loadDevice() async {
    try {
      var info = await _cocktailService.getById(widget.id);
      print(info);
      setState(() {
        _cocktail = info;
      });
    } catch(e) {
      if (e is FormatException) {
        showError(e.message);
      }
    }
  }

  List<Widget> _renderIngredients(Cocktail cocktail) {
    List<Widget> result = [];

    if (cocktail.ingredients.isNotEmpty) {
      for (var ingredient in cocktail.ingredients) {
        result.add(ListItem(text: ingredient));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var loading = _cocktail == null;
    var name = _cocktail == null ? "" : _cocktail!.name;
    var photo = _cocktail == null ? "" : _cocktail!.photo;
    var instructions = _cocktail == null ? "" : _cocktail!.instructions;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}: $name'),
      ),
      drawer: const DrawerWidget(),
      body: Stack(
          children: [
            const ExponentialLinearProgressIndicator(),
            loading ?
              const Center(child: Text("Loading...")) :
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Header(text: "Ingredients"),
                      ListBody(children: _renderIngredients(_cocktail!)),
                      const Header(text: "Instructions"),
                      Paragraph(text: instructions),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Image.network(photo),
                      )
                    ],
                  ),
                ),
              ),
          ],
      ),
    );
  }
}
