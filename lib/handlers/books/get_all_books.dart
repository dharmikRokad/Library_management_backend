import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the GET request for retrieving all books
Future<Response> getAllBooks(RequestContext context) async {
  try {
    final service = context.read<LibraryService>();
    final books = service.getAllBooks();
    return ApiResponse.success(
      body: books.map((b) => b.toJson()).toList(),
    );
  } catch (e) {
    return ApiResponse.serverError('Failed to retrieve books: $e');
  }
}
