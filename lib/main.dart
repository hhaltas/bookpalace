import 'dart:convert';
import 'dart:developer';
import 'package:bookpalace/model/appState.dart';
import 'package:bookpalace/model/book_model.dart';
import 'package:bookpalace/pages/favories/favories.dart';
import 'package:bookpalace/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:bookpalace/utils/app_globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppGlobals.seedColorSheme),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Theme(
            data: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppGlobals.seedColorSheme),
            ),
            child: Text(
              '${AppGlobals.headerText}',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: AppGlobals.seedColorSheme,
          bottom: TabBar(
            tabs: [
              Tab(text: '${AppGlobals.tab1}'),
              Tab(text: '${AppGlobals.tab2}'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Birinci sekme sayfası
            HomeScreen(),

            // İkinci sekme sayfası
            FavorietScreen(),
          ],
        ),
      ),
    );
  }
}
