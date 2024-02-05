import 'dart:convert';
import 'dart:developer';
import 'package:bookpalace/pages/favories/favories.dart';
import 'package:bookpalace/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:bookpalace/utils/app_globals.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppGlobals.seedColorSheme),
        useMaterial3: true,
      ),
      home: MyHomePage(),
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
