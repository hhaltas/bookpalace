import 'package:bookpalace/model/book_model.dart';

class AppState {
  List<SomeRootEntityItems> books;
  List<SomeRootEntityItems> favoriteBooks;

  AppState({
    required this.books,
    required this.favoriteBooks,
  });

  factory AppState.initialState() {
    return AppState(
      books: [],
      favoriteBooks: [],
    );
  }
}

class AddBookAction {
  final SomeRootEntityItems book;

  AddBookAction(this.book);
}

class RemoveBookAction {
  final SomeRootEntityItems book;

  RemoveBookAction(this.book);
}

AppState appReducer(AppState state, dynamic action) {
  if (action is AddBookAction) {
    return AppState(
      books: state.books,
      favoriteBooks: List.from(state.favoriteBooks)..add(action.book),
    );
  } else if (action is RemoveBookAction) {
    return AppState(
      books: state.books,
      favoriteBooks: List.from(state.favoriteBooks)..remove(action.book),
    );
  }
  return state;
}
