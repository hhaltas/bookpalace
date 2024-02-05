import 'dart:convert';
import 'dart:developer';
import 'package:bookpalace/model/book_model.dart';
import 'package:bookpalace/pages/favories/favories.dart';
import 'package:bookpalace/pages/home/home.dart';
import 'package:bookpalace/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:bookpalace/utils/app_globals.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BookService _service = BookService();
  List<SomeRootEntityItems?> books = [];
  List<SomeRootEntityItems?> searchBooks = [];
  bool isSearch = false;
  bool isLoading = false;
  late FocusNode _focusNode;

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _service.fetchBook().then((value) => {
          if (value != null)
            {
              setState(() {
                books = value.items!;
                isLoading = true;
              })
            }
          else
            {print('DATA NULL')}
        });
  }

  void searchFunc(String value) {
    print('${searchBooks.isEmpty}');
    if (value.length >= 3) {
      books.forEach((res) {
        if (res!.volumeInfo!.title!
                .toLowerCase()
                .trim()
                .contains(value.toLowerCase().trim()) ||
            res!.volumeInfo!.authors!
                .toString()
                .toLowerCase()
                .trim()
                .contains(value.toLowerCase().trim())) {
          if (!searchBooks.contains(res)) {
            searchBooks.add(res);
            setState(() {});
          }
        }
      });
    } else {
      searchBooks.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: appbarTitle(),
        trailing: searchIconWidget(),
      ),
      body: !isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : GrockList(
              itemCount:
                  searchBooks.isEmpty ? books.length : searchBooks.length,
              itemBuilder: (context, index) {
                var item =
                    searchBooks.isEmpty ? books[index]! : searchBooks[index]!;
                return Card(
                  child: ListTile(
                    title: Text(item!.volumeInfo!.title!),
                    subtitle: Text(item!.volumeInfo!.authors!.toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        item!.volumeInfo!.imageLinks!.smallThumbnail!,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget searchIconWidget() {
    if (isSearch) {
      return GrockContainer(
        padding: 10.onlyLeftP,
        child: const Icon(CupertinoIcons.clear, size: 24),
        onTap: () {
          setState(() {
            _focusNode.unfocus();
            isSearch = false;
            searchBooks.clear();
          });
        },
      );
    } else {
      return GrockContainer(
        padding: 10.onlyLeftP,
        child: const Icon(CupertinoIcons.search, size: 24),
        onTap: () {
          setState(() {
            _focusNode.requestFocus();
            isSearch = true;
          });
        },
      );
    }
  }

  Widget appbarTitle() {
    if (isSearch) {
      return CupertinoTextField(
        controller: searchController,
        focusNode: _focusNode,
        textInputAction: TextInputAction.search,
        placeholder: 'Yazar veya Kitap adı yazınız...',
        onSubmitted: (value) {
          searchFunc(value);
        },
      );
    } else {
      return const Text('Kitap Sarayı');
    }
  }

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: DefaultTabController(

  //       length: 2,
  //       child: Scaffold(
  //         appBar: AppBar(
  //           bottom: TabBar(tabs: [
  //             Tab(
  //               text: 'Kitaplar',
  //             ),
  //             Tab(
  //               text: 'Favoriler',
  //             ),
  //           ]),
  //         ),
  //         body: TabBarView(
  //           children: [
  //             MyHome(),
  //             FavorietScreen(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}


/*

Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox40,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Kitap Sarayı",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(Icons.search_outlined),
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectIndex = index;
                            });
                          },
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 05),
                          tabs: [
                            Container(
                              width: 230,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: const Color(0xffe9e9e9)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Kitaplar',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              width: 230,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: const Color(0xffe9e9e9)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Favorilerim',
                                  style: TextStyle(color: gBlack, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 */