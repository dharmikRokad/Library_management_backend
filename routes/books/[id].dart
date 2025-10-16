import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/handlers/books/delete_book.dart';
import 'package:dart_frog_demo/handlers/books/get_book.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => await getBook(context, id),
    HttpMethod.delete => await deleteBook(context, id),
    _ => ApiResponse.methodNotAllowed(),
  };
}
