import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the POST request for adding a new book
Future<Response> addBook(RequestContext context) async {
  try {
    // Validate that we have a body
    final body = await context.request.body();
    if (body.isEmpty) {
      return ApiResponse.badRequest('Request body is required');
    }

    // Parse and validate JSON
    late final Map<String, dynamic> data;
    try {
      data = jsonDecode(body) as Map<String, dynamic>;
    } catch (e) {
      return ApiResponse.badRequest('Invalid JSON format');
    }

    // Validate required fields
    final requiredFields = ['title', 'author', 'isbn'];
    final missingFields = requiredFields
        .where((field) => !data.containsKey(field) || data[field] == null)
        .toList();

    if (missingFields.isNotEmpty) {
      return ApiResponse.badRequest(
        'Missing required fields: ${missingFields.join(', ')}',
      );
    }

    // Validate field types
    if (data.values.any((value) => value is! String)) {
      return ApiResponse.badRequest(
        'All fields (title, author, isbn) must be strings',
      );
    }

    // Create book
    final service = context.read<LibraryService>();
    final book = service.addBook(
      data['title'] as String,
      data['author'] as String,
      data['isbn'] as String,
    );

    if (book == null) {
      return ApiResponse.badRequest(
        'ISBN already exists',
      );
    }

    return ApiResponse.success(
      body: book.toJson(),
      statusCode: 201,
    );
  } catch (e) {
    return ApiResponse.serverError('Failed to create book: $e');
  }
}
