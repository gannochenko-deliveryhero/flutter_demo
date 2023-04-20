import 'package:flutter/material.dart';

import '../services/cocktails.dart';
import '../util.dart';
import '../widgets/drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    var loading = _cocktail == null;
    var name = _cocktail == null ? "" : _cocktail!.name;

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
              const Text("Loaded"),
          ],
      ),
    );
  }
}
