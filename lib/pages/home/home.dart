import 'dart:convert';
import 'dart:developer';
import 'package:bookpalace/model/appState.dart';
import 'package:bookpalace/model/book_model.dart';
import 'package:bookpalace/pages/book/book.dart';
import 'package:bookpalace/pages/favories/favories.dart';
import 'package:bookpalace/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grock/grock.dart';
import 'package:bookpalace/utils/app_globals.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BookService _service = BookService();
  List<SomeRootEntityItems?> books = [];
  List<SomeRootEntityItems?> searchBooks = [];
  List<SomeRootEntityItems?> favoriesBooks = [];
  final List<SomeRootEntityItems?> selectedBook = [];

  bool isSearch = false;
  bool isLoading = false;
  bool isFavorite = false;

  late FocusNode _focusNode;

  //search Liste text
  TextEditingController searchController = TextEditingController();
  final String searchQuery = '';

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
    // print('${searchBooks.isEmpty}');
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

  void toggleFavorite(item) {
    setState(() {
      if (favoriesBooks.contains(item)) {
        favoriesBooks.remove(item);
        StoreProvider.of<AppState>(context).dispatch(RemoveBookAction(item));
      } else {
        favoriesBooks.add(item);
        StoreProvider.of<AppState>(context).dispatch(AddBookAction(item));
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
          placeholder: '${AppGlobals.placeHolderText}',
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
                                ? AppGlobals.favorieSelected
                                : AppGlobals.favorieUnSelected,
                          ),
                          onPressed: () {
                            toggleFavorite(item);
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
