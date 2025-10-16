import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/handlers/books/add_book.dart';
import 'package:dart_frog_demo/handlers/books/get_all_books.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await getAllBooks(context),
    HttpMethod.post => await addBook(context),
    _ => ApiResponse.methodNotAllowed(),
  };
}
