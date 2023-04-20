import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/cocktails.dart';
import '../util.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = "Cocktails";

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Cocktail> _cocktails = [];
  final CocktailService _cocktailService = CocktailService();

  // @override
  // HomePageState(): super() {}

  // @override
  // void dispose() {
  //   // todo: stop the process, if running
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadCocktails();
  // }

  void _loadCocktails() async {
    try {
      var info = await _cocktailService.getList();
      print(info);
      setState(() {
        _cocktails = info;
      });
    } catch (e) {
      print("ERROR");
      print(e);
      if (e is FormatException) {
        showError(e.message);
      }
    }
  }

  void _onActionButtonClick () {
    _loadCocktails();
  }

  Future<void> _refreshList() async {
    _loadCocktails();
    await Future.delayed(const Duration(seconds: 1));
  }

  void _onDeviceClick(BuildContext context, Cocktail cocktail) {
    GoRouter.of(context).go('/cocktail/${cocktail.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const DrawerWidget(),
      body: Stack(
          children: [
            const LinearProgressIndicator(value: 0),
            RefreshIndicator(
              onRefresh: _refreshList,
              child:ListView.builder(
                itemCount: _cocktails.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(_cocktails[index].name),
                      subtitle: const Text('Alcoholic: ✅ YES'),
                      onTap: () => _onDeviceClick(context, _cocktails[index]),
                    ),
                  );
                },
              ),
            )
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onActionButtonClick,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
