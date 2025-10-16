import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the GET request for retrieving a specific member
Future<Response> getMember(RequestContext context, String id) async {
  try {
    if (id.isEmpty) {
      return ApiResponse.badRequest('Member ID cannot be empty');
    }

    final service = context.read<LibraryService>();
    final member = service.getMember(id);

    if (member == null) {
      return ApiResponse.notFound('Member not found');
    }

    return ApiResponse.success(body: member.toJson());
  } catch (e) {
    return ApiResponse.serverError('Failed to retrieve member: $e');
  }
}
