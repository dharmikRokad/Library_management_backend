import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the POST request for creating a new loan
Future<Response> createLoan(RequestContext context) async {
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
    final requiredFields = ['bookId', 'memberId'];
    final missingFields = requiredFields
        .where((field) => !data.containsKey(field) || data[field] == null)
        .toList();

    if (missingFields.isNotEmpty) {
      return ApiResponse.badRequest(
        'Missing required fields: ${missingFields.join(', ')}',
      );
    }

    // Create loan
    final service = context.read<LibraryService>();
    final loan = service.createLoan(
      data['bookId'] as String,
      data['memberId'] as String,
    );

    if (loan == null) {
      return ApiResponse.badRequest(
        'Could not create loan. Book might be unavailable or IDs might be invalid.',
      );
    }

    return ApiResponse.success(
      body: loan.toJson(),
      statusCode: 201,
    );
  } catch (e) {
    return ApiResponse.serverError('Failed to create loan: $e');
  }
}
