import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the DELETE request for removing a book
Future<Response> deleteBook(RequestContext context, String id) async {
  try {
    if (id.isEmpty) {
      return ApiResponse.badRequest('Book ID cannot be empty');
    }

    final service = context.read<LibraryService>();
    final success = service.deleteBook(id);

    if (success) {
      return ApiResponse.success(
        body: {'message': 'Book deleted successfully'},
      );
    } else {
      return ApiResponse.notFound('Book not found');
    }
  } catch (e) {
    return ApiResponse.serverError('Failed to delete book: $e');
  }
}
