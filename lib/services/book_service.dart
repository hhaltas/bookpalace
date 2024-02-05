import 'dart:convert';
import 'package:bookpalace/model/book_model.dart';
import 'package:http/http.dart' as http;

class BookService {
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const String queryParameters =
      'q=Tolkien&maxResults=20&startIndex=20&orderBy=relevance';
  final String url = '$baseUrl?$queryParameters';

  Future<SomeRootEntity?> fetchBook() async {
    try {
      var response = await http.get(Uri.parse(url));

      print('Response ==> ${response}');

      if (response.statusCode == 200) {
        var jsonData = SomeRootEntity.fromJson(jsonDecode(response.body));
        return jsonData;
      } else {
        print('Book Service error => ${response.statusCode}');
      }
    } catch (error) {
      print('Error during API call: $error');
    }
  }
}
