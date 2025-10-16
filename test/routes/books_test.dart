import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_demo/models/book.dart';
import 'package:dart_frog_demo/services/library_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/books/[id].dart' as book_route;
import '../../routes/books/index.dart' as books_route;

class MockRequestContext extends Mock implements RequestContext {}

class MockRequest extends Mock implements Request {}

class MockLibraryService extends Mock implements LibraryService {}

void main() {
  late MockRequestContext context;
  late MockRequest request;
  late MockLibraryService libraryService;

  setUp(() {
    context = MockRequestContext();
    request = MockRequest();
    libraryService = MockLibraryService();

    when(() => context.read<LibraryService>()).thenReturn(libraryService);
    when(() => context.request).thenReturn(request);
  });

  group('GET /books', () {
    test('returns empty list when no books exist', () async {
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => libraryService.getAllBooks()).thenReturn([]);

      final response = await books_route.onRequest(context);
      expect(response.statusCode, equals(200));
      expect(await response.json(), equals([]));
    });
  });

  group('POST /books', () {
    test('creates a new book', () async {
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.body()).thenAnswer((_) async => '''
        {
          "title": "Test Book",
          "author": "Test Author",
          "isbn": "123-456-789"
        }
      ''');

      when(
        () => libraryService.addBook(any(), any(), any()),
      ).thenReturn(
        Book(
          id: 'test-id',
          title: 'Test Book',
          author: 'Test Author',
          isbn: '123-456-789',
          isAvailable: true,
        ),
      );

      final response = await books_route.onRequest(context);
      expect(response.statusCode, equals(201));

      final json = await response.json() as Map<String, dynamic>;
      expect(json['title'], equals('Test Book'));
    });
  });

  group('GET /books/:id', () {
    test('returns 404 when book not found', () async {
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => libraryService.getBook(any())).thenReturn(null);

      final response = await book_route.onRequest(context, 'non-existent-id');
      expect(response.statusCode, equals(404));
    });

    test('returns book when found', () async {
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => libraryService.getBook(any())).thenReturn(
        Book(
          id: 'test-id',
          title: 'Test Book',
          author: 'Test Author',
          isbn: '123-456-789',
          isAvailable: true,
        ),
      );

      final response = await book_route.onRequest(context, 'test-id');
      expect(response.statusCode, equals(200));

      final json = await response.json() as Map<String, dynamic>;
      expect(json['id'], equals('test-id'));
    });
  });
}
