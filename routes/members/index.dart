import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/handlers/members/add_member.dart';
import 'package:dart_frog_demo/handlers/members/get_all_members.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await getAllMembers(context),
    HttpMethod.post => await addMember(context),
    _ => ApiResponse.methodNotAllowed(),
  };
}
