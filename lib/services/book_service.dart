import 'dart:convert';

import 'package:bookpalace/model/book_model.dart';
import 'package:http/http.dart' as http;

class BookService {
  final String url =
      'https://www.googleapis.com/books/v1/volumes?q=Tolkien&maxResults=20&startIndex=20&orderBy=relevance';
  Future<SomeRootEntity?> fetchBook() async {
    var response = await http.get(Uri.parse(url));
    print('response ==> ${response}');
    if (response.statusCode == 200) {
      var jsonData = SomeRootEntity.fromJson(jsonDecode(response.body));
      return jsonData;
    } else {
      print('Book Service error => ${response.statusCode}');
    }
  }
}
