import 'dart:convert';
import 'dart:developer';
import 'package:bookpalace/model/book_model.dart';
import 'package:bookpalace/pages/book/book.dart';
import 'package:bookpalace/pages/favories/favories.dart';
import 'package:bookpalace/services/book_service.dart';
import 'package:bookpalace/utils/app_store.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:bookpalace/utils/app_globals.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> liste = [
    'Öğe 1',
    'Öğe 2',
    'Öğe 3',
    // ... Diğer öğeler
  ];

  List<String> filtrelenmisListe = [];
  BookService _service = BookService();
  List<SomeRootEntityItems?> books = [];
  List<SomeRootEntityItems?> searchBooks = [];
  List<SomeRootEntityItems?> favoriesBooks = [];
  final List<SomeRootEntityItems?> selectedBook = [];

  List<bool> isFavoriteList = List.generate(20, (index) => false);

  bool isSearch = false;
  bool isLoading = false;
  bool isFavorite = false;

  late FocusNode _focusNode;

  TextEditingController searchController = TextEditingController();
  final String searchQuery = '';

  TextEditingController aramaController = TextEditingController();

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

  void toggleFavorite(int index) {
    setState(() {
      if (favoriesBooks.contains(books[index])) {
        favoriesBooks.remove(books[index]);
      } else {
        favoriesBooks.add(books[index]);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Arama çubuğu
        CupertinoTextField(
          controller: searchController,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          placeholder: 'Yazar veya Kitap adı yazınız...',
          onSubmitted: (value) {
            searchFunc(value);
          },
        ),
        // Liste
        Expanded(
          child: !isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : GrockList(
                  itemCount:
                      searchBooks.isEmpty ? books.length : searchBooks.length,
                  itemBuilder: (context, index) {
                    var item = searchBooks.isEmpty
                        ? books[index]!
                        : searchBooks[index]!;
                    return Card(
                      child: ListTile(
                        title: Text(item!.volumeInfo!.title!),
                        subtitle: Text(item!.volumeInfo!.authors!.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            item!.volumeInfo!.imageLinks!.smallThumbnail!,
                          ),
                        ),
                        trailing: IconButton(
                          // Sağ tarafta başka bir widget (IconButton) ekleyin
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: favoriesBooks.contains(books[index])
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            toggleFavorite(index);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailScreen(book: item),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
