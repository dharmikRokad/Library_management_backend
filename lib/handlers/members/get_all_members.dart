import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

/// Handles the GET request for retrieving all members
Future<Response> getAllMembers(RequestContext context) async {
  try {
    final service = context.read<LibraryService>();
    final members = service.getAllMembers();
    return ApiResponse.success(
      body: members.map((m) => m.toJson()).toList(),
    );
  } catch (e) {
    return ApiResponse.serverError('Failed to retrieve members: $e');
  }
}
