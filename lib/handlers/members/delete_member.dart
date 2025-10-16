import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the DELETE request for removing a member
Future<Response> deleteMember(RequestContext context, String id) async {
  try {
    if (id.isEmpty) {
      return ApiResponse.badRequest('Member ID cannot be empty');
    }

    final service = context.read<LibraryService>();
    final success = service.deleteMember(id);

    if (success) {
      return ApiResponse.success(
        body: {'message': 'Member deleted successfully'},
      );
    } else {
      return ApiResponse.notFound('Member not found');
    }
  } catch (e) {
    return ApiResponse.serverError('Failed to delete member: $e');
  }
}
