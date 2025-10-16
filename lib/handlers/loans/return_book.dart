import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the POST request for returning a book
Future<Response> returnBook(RequestContext context, String id) async {
  try {
    if (id.isEmpty) {
      return ApiResponse.badRequest('Loan ID cannot be empty');
    }

    final service = context.read<LibraryService>();
    final success = service.returnBook(id);

    if (success) {
      return ApiResponse.success(
        body: {'message': 'Book returned successfully'},
      );
    } else {
      return ApiResponse.badRequest(
        'Could not return book. The loan might not exist or the book might already be returned.',
      );
    }
  } catch (e) {
    return ApiResponse.serverError('Failed to return book: $e');
  }
}
