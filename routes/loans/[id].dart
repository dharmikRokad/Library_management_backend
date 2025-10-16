import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/handlers/loans/get_loan.dart';
import 'package:dart_frog_demo/handlers/loans/return_book.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => await getLoan(context, id),
    HttpMethod.post => (context.request.uri.path.endsWith('/return'))
        ? await returnBook(context, id)
        : ApiResponse.notFound('Endpoint not found'),
    _ => ApiResponse.methodNotAllowed(),
  };
}
