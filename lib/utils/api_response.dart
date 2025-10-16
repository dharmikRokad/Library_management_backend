import 'package:dart_frog/dart_frog.dart';

/// Utility class for creating consistent API responses
class ApiResponse {
  /// Creates a success response with the given data
  static Response success({
    required dynamic body,
    int statusCode = 200,
  }) {
    return Response.json(
      statusCode: statusCode,
      body: body,
    );
  }

  /// Creates an error response with the given message
  static Response error({
    required String message,
    int statusCode = 400,
    dynamic details,
  }) {
    return Response.json(
      statusCode: statusCode,
      body: {
        'error': message,
        if (details != null) 'details': details,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Creates a not found response with optional custom message
  static Response notFound([String? message]) {
    return error(
      message: message ?? 'Resource not found',
      statusCode: 404,
    );
  }

  /// Creates a bad request response with optional custom message
  static Response badRequest([String? message]) {
    return error(
      message: message ?? 'Invalid request',
      statusCode: 400,
    );
  }

  /// Creates a server error response with optional custom message
  static Response serverError([String? message]) {
    return error(
      message: message ?? 'Internal server error',
      statusCode: 500,
    );
  }

  /// Creates a method not allowed response
  static Response methodNotAllowed() {
    return error(
      message: 'Method not allowed',
      statusCode: 405,
    );
  }
}
