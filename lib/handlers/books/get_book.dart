import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the GET request for retrieving a specific book
Future<Response> getBook(RequestContext context, String id) async {
  try {
    if (id.isEmpty) {
      return ApiResponse.badRequest('Book ID cannot be empty');
    }

    final service = context.read<LibraryService>();
    final book = service.getBook(id);

    if (book == null) {
      return ApiResponse.notFound('Book not found');
    }

    return ApiResponse.success(body: book.toJson());
  } catch (e) {
    return ApiResponse.serverError('Failed to retrieve book: $e');
  }
}
