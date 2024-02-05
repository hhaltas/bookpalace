import 'package:bookpalace/model/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final SomeRootEntityItems book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kİtap İçeriği'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (book.volumeInfo?.imageLinks?.smallThumbnail != null)
                  Image.network(
                    book.volumeInfo!.imageLinks!.smallThumbnail!,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 10),
                Text(
                  'Title:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  book.volumeInfo?.title ?? 'N/A',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Authors:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  book.volumeInfo?.description ?? 'N/A',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  book.volumeInfo?.description ?? 'N/A',
                  style: TextStyle(fontSize: 16),
                ),
                // Diğer detayları ekleyin
              ],
            ),
          ),
        ));
  }
}
//(( ${item!.volumeInfo!.authors!.toString()}))