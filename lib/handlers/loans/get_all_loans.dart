import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the GET request for retrieving all loans
Future<Response> getAllLoans(RequestContext context) async {
  try {
    final service = context.read<LibraryService>();
    final loans = service.getAllLoans();
    return ApiResponse.success(
      body: loans.map((l) => l.toJson()).toList(),
    );
  } catch (e) {
    return ApiResponse.serverError('Failed to retrieve loans: $e');
  }
}
