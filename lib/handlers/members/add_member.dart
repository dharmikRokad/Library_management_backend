import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the POST request for adding a new member
Future<Response> addMember(RequestContext context) async {
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
    final requiredFields = ['name', 'email', 'membershipNumber'];
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
        'All fields (name, email, membershipNumber) must be strings',
      );
    }

    // Create member
    final service = context.read<LibraryService>();
    final member = service.addMember(
      data['name'] as String,
      data['email'] as String,
      data['membershipNumber'] as String,
    );

    if (member == null) {
      return ApiResponse.badRequest(
        'Membership number already exists',
      );
    }

    return ApiResponse.success(
      body: member.toJson(),
      statusCode: 201,
    );
  } catch (e) {
    return ApiResponse.serverError('Failed to create member: $e');
  }
}
