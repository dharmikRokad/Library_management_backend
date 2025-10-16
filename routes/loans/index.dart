import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/handlers/loans/create_loan.dart';
import 'package:dart_frog_demo/handlers/loans/get_all_loans.dart';
import 'package:dart_frog_demo/utils/api_response.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await getAllLoans(context),
    HttpMethod.post => await createLoan(context),
    _ => ApiResponse.methodNotAllowed(),
  };
}
