// import 'package:bookpalace/utils/actions.dart';
// import 'package:bookpalace/model/book_model.dart';

// // int counterReducer(int state, dynamic action) {
// //   if (action == ReducerAction.addBook) {
// //     state = state + 1;
// //   } else if (action == ReducerAction.Decrement) {
// //     state = state - 1;
// //   }
// //   return state;
// // }

// List<SomeRootEntityItems> bookReducer(
//   List<SomeRootEntityItems> favBook,
//   List<SomeRootEntityItems> value,
//   ReducerAction action,
// ) {
//   if (action == ReducerAction.addBook) {
//     if (!favBook.contains(value)) {
//       favBook.add(value);
//     }
//   } else if (action == ReducerAction.removeBook) {
//     favBook.removeWhere((item) => item == value);
//   }
//   return favBook;
// }
