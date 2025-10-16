import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/services/library_service.dart';

final _libraryService = LibraryService();

Handler middleware(Handler handler) {
  return handler.use(
    provider<LibraryService>((context) => _libraryService),
  );
}
