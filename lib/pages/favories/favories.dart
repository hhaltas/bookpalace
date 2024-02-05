import 'package:bookpalace/model/appState.dart';
import 'package:bookpalace/model/book_model.dart';
import 'package:bookpalace/pages/book/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bookpalace/utils/actions.dart';

class FavorietScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, List<SomeRootEntityItems>>(
        converter: (store) => store.state.favoriteBooks,
        builder: (context, favoriteBooks) {
          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              final item = favoriteBooks[index];
              return ListTile(
                title: Text(item!.volumeInfo!.title!),
                subtitle: Text(item!.volumeInfo!.authors!.toString()),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    item!.volumeInfo!.imageLinks!.smallThumbnail!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
