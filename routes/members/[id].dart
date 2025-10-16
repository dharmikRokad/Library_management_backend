import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/handlers/members/delete_member.dart';
import 'package:dart_frog_demo/handlers/members/get_member.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => await getMember(context, id),
    HttpMethod.delete => await deleteMember(context, id),
    _ => ApiResponse.methodNotAllowed(),
  };
}
