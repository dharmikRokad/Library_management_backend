import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the GET request for retrieving a specific loan
Future<Response> getLoan(RequestContext context, String id) async {
  try {
    if (id.isEmpty) {
      return ApiResponse.badRequest('Loan ID cannot be empty');
    }

    final service = context.read<LibraryService>();
    final loan = service.getLoan(id);

    if (loan == null) {
      return ApiResponse.notFound('Loan not found');
    }

    return ApiResponse.success(body: loan.toJson());
  } catch (e) {
    return ApiResponse.serverError('Failed to retrieve loan: $e');
  }
}
